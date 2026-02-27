import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/store_controller.dart';
import '../location_picker_screen.dart';

/// Store registration screen
/// Allows users to register their store
class StoreRegistrationScreen extends StatefulWidget {
  const StoreRegistrationScreen({super.key});

  @override
  State<StoreRegistrationScreen> createState() => _StoreRegistrationScreenState();
}

class _StoreRegistrationScreenState extends State<StoreRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  
  late final StoreController _storeController;
  
  StoreCategory? _selectedCategory;
  double _latitude = 0;
  double _longitude = 0;
  String? _city;
  double _deliveryRadius = 5.0;
  
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _storeController = Get.put(StoreController());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Text(
          'store_management.register_store'.tr,
          style: AppTypography.titleMedium(context).copyWith(
            color: colors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (_storeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stepper(
          currentStep: _currentStep,
          onStepContinue: _onStepContinue,
          onStepCancel: _onStepCancel,
          controlsBuilder: (context, details) {
            return Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: _storeController.isSaving.value 
                          ? null 
                          : details.onStepContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: _storeController.isSaving.value 
                            ? SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Text(
                                _currentStep == 2 
                                  ? 'common.submit'.tr 
                                  : 'common.next'.tr,
                                style: AppTypography.labelLarge(context).copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ),
                  if (_currentStep > 0) ...[
                    SizedBox(width: 12.w),
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: OutlinedButton(
                          onPressed: details.onStepCancel,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: colors.textPrimary,
                            side: BorderSide(color: colors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'common.back'.tr,
                            style: AppTypography.labelLarge(context).copyWith(
                              color: colors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
          steps: [
            // Step 1: Category Selection
            Step(
              title: Text(
                'store_management.store_category'.tr,
                style: AppTypography.labelLarge(context).copyWith(
                  color: colors.textPrimary,
                ),
              ),
              content: _buildCategoryStep(colors),
              isActive: _currentStep >= 0,
              state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            ),
            // Step 2: Store Info
            Step(
              title: Text(
                'store_management.store_profile'.tr,
                style: AppTypography.labelLarge(context).copyWith(
                  color: colors.textPrimary,
                ),
              ),
              content: _buildInfoStep(colors),
              isActive: _currentStep >= 1,
              state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            ),
            // Step 3: Location & Delivery
            Step(
              title: Text(
                'store_management.store_address'.tr,
                style: AppTypography.labelLarge(context).copyWith(
                  color: colors.textPrimary,
                ),
              ),
              content: _buildLocationStep(colors),
              isActive: _currentStep >= 2,
              state: _currentStep > 2 ? StepState.complete : StepState.indexed,
            ),
          ],
        );
      }),
    );
  }

  Widget _buildCategoryStep(dynamic colors) {
    return Obx(() {
      final categories = _storeController.storeCategories;
      
      if (categories.isEmpty) {
        return Center(
          child: Text(
            'common.loading'.tr,
            style: AppTypography.bodyMedium(context).copyWith(
              color: colors.textSecondary,
            ),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'store_management.select_category'.tr,
            style: AppTypography.bodyMedium(context).copyWith(
              color: colors.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 1.3,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = _selectedCategory?.id == category.id;
              
              return _CategoryCard(
                category: category,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              );
            },
          ),
        ],
      );
    });
  }

  Widget _buildInfoStep(dynamic colors) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'store_management.store_name'.tr,
              hintText: 'store_management.store_name'.tr,
              prefixIcon: const Icon(Iconsax.shop),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              filled: true,
              fillColor: colors.surface,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter store name';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'store_management.store_description'.tr,
              hintText: 'store_management.store_description'.tr,
              prefixIcon: const Icon(Iconsax.document_text),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              filled: true,
              fillColor: colors.surface,
            ),
            maxLines: 3,
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: 'store_management.store_phone'.tr,
              hintText: '+212 XXX XXX XXX',
              prefixIcon: const Icon(Iconsax.call),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              filled: true,
              fillColor: colors.surface,
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter phone number';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'store_management.store_email'.tr,
              hintText: 'store@example.com',
              prefixIcon: const Icon(Iconsax.sms),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              filled: true,
              fillColor: colors.surface,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationStep(dynamic colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Address picker
        GestureDetector(
          onTap: _pickLocation,
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.border),
            ),
            child: Row(
              children: [
                Icon(
                  Iconsax.location,
                  color: _latitude != 0 ? colors.primary : colors.textSecondary,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'store_management.store_address'.tr,
                        style: AppTypography.labelMedium(context).copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        _addressController.text.isNotEmpty 
                          ? _addressController.text 
                          : 'Tap to select location',
                        style: AppTypography.bodyMedium(context).copyWith(
                          color: _addressController.text.isNotEmpty 
                            ? colors.textPrimary 
                            : colors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Iconsax.arrow_right_3,
                  color: colors.textSecondary,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24.h),
        
        // Delivery radius slider
        Text(
          'store_management.delivery_radius'.tr,
          style: AppTypography.labelMedium(context).copyWith(
            color: colors.textSecondary,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: _deliveryRadius,
                min: 1,
                max: 20,
                divisions: 19,
                label: '${_deliveryRadius.toStringAsFixed(0)} km',
                onChanged: (value) {
                  setState(() {
                    _deliveryRadius = value;
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                '${_deliveryRadius.toStringAsFixed(0)} km',
                style: AppTypography.labelLarge(context).copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _pickLocation() async {
    final result = await Get.to<Map<String, dynamic>>(
      () => const LocationPickerScreen(),
      arguments: {
        'isPickup': false,
      },
    );

    if (result != null) {
      debugPrint('[StoreRegistration] Location result: $result');
      setState(() {
        final rawLat = result['latitude'] ?? result['lat'];
        final rawLng = result['longitude'] ?? result['lng'];

        _latitude = rawLat is num ? rawLat.toDouble() : 0;
        _longitude = rawLng is num ? rawLng.toDouble() : 0;
        _addressController.text = result['address'] ?? '';
        _city = result['city'];
        
        debugPrint('[StoreRegistration] Parsed coordinates: lat=$_latitude, lng=$_longitude');
      });
    } else {
      debugPrint('[StoreRegistration] Location picker cancelled');
    }
  }

  void _onStepContinue() {
    if (_currentStep == 0) {
      if (_selectedCategory == null) {
        Get.snackbar(
          'common.error'.tr,
          'store_management.select_category'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      setState(() => _currentStep++);
    } else if (_currentStep == 1) {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      setState(() => _currentStep++);
    } else if (_currentStep == 2) {
      if (_latitude == 0 || _longitude == 0) {
        Get.snackbar(
          'common.error'.tr,
          'Please select store location',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      _submitRegistration();
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  Future<void> _submitRegistration() async {
    final success = await _storeController.createStore(
      storeCategoryId: _selectedCategory!.id!,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim().isNotEmpty 
        ? _descriptionController.text.trim() 
        : null,
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim().isNotEmpty 
        ? _emailController.text.trim() 
        : null,
      address: _addressController.text.trim(),
      latitude: _latitude,
      longitude: _longitude,
      city: _city,
      deliveryRadiusKm: _deliveryRadius,
    );

    if (success) {
      Get.snackbar(
        'common.success'.tr,
        'store_management.create_store_success'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed('/store-dashboard');
    } else {
      Get.snackbar(
        'common.error'.tr,
        _storeController.errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

/// Category card widget
class _CategoryCard extends StatelessWidget {
  final StoreCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    // Parse color from hex
    Color categoryColor = colors.primary;
    if (category.colorHex != null) {
      try {
        categoryColor = Color(int.parse(category.colorHex!.replaceFirst('#', '0xFF')));
      } catch (_) {}
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isSelected 
            ? categoryColor.withValues(alpha: 0.1) 
            : colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? categoryColor : colors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: categoryColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconForCategory(category.iconName),
                color: categoryColor,
                size: 24.sp,
              ),
            ),
            SizedBox(height: 8.h),
            // Name
            Text(
              category.nameEn,
              style: AppTypography.labelMedium(context).copyWith(
                color: isSelected ? categoryColor : colors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForCategory(String? iconName) {
    switch (iconName) {
      case 'restaurant':
        return Iconsax.reserve;
      case 'fastfood':
        return Iconsax.coffee;
      case 'coffee':
        return Iconsax.coffee;
      case 'shopping_cart':
        return Iconsax.shopping_cart;
      case 'medical_services':
        return Iconsax.health;
      case 'devices':
        return Iconsax.mobile;
      case 'local_florist':
        return Iconsax.gift;
      case 'pets':
        return Iconsax.pet;
      case 'menu_book':
        return Iconsax.book;
      case 'store':
      default:
        return Iconsax.shop;
    }
  }
}
