import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency_helper.dart';
import '../../../../core/controllers/driver_services_controller.dart';
import '../../../../shared/widgets/pricing_config_widget.dart';
import 'package:awhar_client/awhar_client.dart';

/// Add new service screen with multi-step form
class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final controller = Get.find<DriverServicesController>();
  final PageController pageController = PageController();
  final RxInt currentStep = 0.obs;

  // Form data
  ServiceCategory? selectedCategory;
  Service? selectedService;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final RxList<File> selectedImages = <File>[].obs;
  final Rx<double?> basePrice = Rx<double?>(null);
  final Rx<double?> pricePerKm = Rx<double?>(null);
  final Rx<double?> pricePerHour = Rx<double?>(null);
  final Rx<double?> minPrice = Rx<double?>(null);

  // Reactive validation states
  final RxBool isTitleValid = false.obs;
  final RxBool isDescriptionValid = false.obs;
  
  // Reactive text values for preview
  final RxString titleText = ''.obs;
  final RxString descriptionText = ''.obs;

  @override
  void initState() {
    super.initState();
    debugPrint('🚀 AddServiceScreen initialized');
    debugPrint('   Categories loaded: ${controller.categories.length}');
    for (var cat in controller.categories) {
      debugPrint('   - ${cat.name} (ID: ${cat.id})');
    }

    // Add listeners for reactive validation and preview
    titleController.addListener(() {
      isTitleValid.value = titleController.text.trim().length >= 3;
      titleText.value = titleController.text.trim();
    });
    descriptionController.addListener(() {
      isDescriptionValid.value = descriptionController.text.trim().length >= 10;
      descriptionText.value = descriptionController.text.trim();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void nextStep() {
    if (currentStep.value < 4) {
      currentStep.value++;
      pageController.animateToPage(
        currentStep.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
      pageController.animateToPage(
        currentStep.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> submitService() async {
    debugPrint('\n🎯 === SUBMIT SERVICE CLICKED ===');
    debugPrint('   Selected Category: ${selectedCategory?.name}');
    debugPrint('   Selected Service: ${selectedService?.nameEn}');
    debugPrint('   Title: ${titleController.text.trim()}');
    debugPrint('   Description: ${descriptionController.text.trim()}');
    debugPrint('   Base Price: ${basePrice.value}');
    debugPrint('   Price/KM: ${pricePerKm.value}');
    debugPrint('   Price/Hour: ${pricePerHour.value}');
    debugPrint('   Min Price: ${minPrice.value}');

    if (selectedService == null || selectedCategory == null) {
      debugPrint('❌ Missing service or category!');
      Get.snackbar('common.error'.tr, 'driver.services.select_service'.tr);
      return;
    }

    debugPrint('📞 Calling controller.addService...');
    final success = await controller.addService(
      serviceId: selectedService!.id!,
      categoryId: selectedCategory!.id!,
      title: titleController.text.trim().isEmpty ? null : titleController.text.trim(),
      description: descriptionController.text.trim().isEmpty ? null : descriptionController.text.trim(),
      basePrice: basePrice.value,
      pricePerKm: pricePerKm.value,
      pricePerHour: pricePerHour.value,
      minPrice: minPrice.value,
    );

    debugPrint('📊 Add service result: $success');

    if (success != null) {
      debugPrint('✅ Service added successfully (ID: $success)');
      
      // Upload images if any
      if (selectedImages.isNotEmpty) {
        debugPrint('📸 Uploading ${selectedImages.length} images...');
        
        for (final imageFile in selectedImages) {
          try {
            debugPrint('🔄 Uploading image: ${imageFile.path}');
            
            final imageResult = await controller.uploadServiceImage(
              driverServiceId: success,  // The service ID returned from addDriverService
              imageFile: File(imageFile.path),
            );
            
            if (imageResult != null) {
              debugPrint('✅ Image uploaded successfully: ${imageResult.imageUrl}');
            } else {
              debugPrint('❌ Failed to upload image');
            }
          } catch (e) {
            debugPrint('❌ Error uploading image: $e');
          }
        }
      }
      
      debugPrint('🎉 All done! Navigating to dashboard...');
      
      // Navigate to dashboard and remove all previous routes
      Get.offAllNamed('/driver/dashboard');
      
      // Show success message
      Get.snackbar(
        'common.success'.tr,
        'driver.services.service_published'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.brightness == Brightness.dark 
            ? AppColors.dark.success 
            : AppColors.light.success,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        icon: Icon(Iconsax.tick_circle, color: Colors.white),
      );
      
      debugPrint('✅ Navigation to dashboard completed');
    } else {
      debugPrint('❌ Service addition failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        title: Text(
          'driver.services.add_service'.tr,
          style: AppTypography.headlineMedium(context).copyWith(color: colors.textPrimary),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: colors.textPrimary),
          onPressed: () {
            if (currentStep.value > 0 ||
                titleController.text.isNotEmpty ||
                descriptionController.text.isNotEmpty ||
                selectedImages.isNotEmpty) {
              _showDiscardDialog(colors);
            } else {
              Get.back();
            }
          },
        ),
      ),
      body: Column(
        children: [
          // Progress indicator
          Obx(() => _StepIndicator(
                currentStep: currentStep.value,
                totalSteps: 5,
                colors: colors,
              )),

          // Page view
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) => currentStep.value = index,
              children: [
                _Step1SelectCategory(
                  controller: controller,
                  colors: colors,
                  selectedCategory: selectedCategory,
                  selectedService: selectedService,
                  onCategorySelected: (category) {
                    debugPrint('📝 Setting state - selectedCategory: ${category.name}');
                    setState(() => selectedCategory = category);
                    debugPrint('✅ State updated - selectedCategory is now: ${selectedCategory?.name}');
                  },
                  onServiceSelected: (service) {
                    debugPrint('📝 Setting state - selectedService: ${service.nameEn}');
                    setState(() => selectedService = service);
                    debugPrint('✅ State updated - selectedService is now: ${selectedService?.nameEn}');
                  },
                ),
                _Step2EnterDetails(
                  titleController: titleController,
                  descriptionController: descriptionController,
                  colors: colors,
                  isTitleValid: isTitleValid,
                  isDescriptionValid: isDescriptionValid,
                ),
                _Step3UploadImages(
                  selectedImages: selectedImages,
                  controller: controller,
                  colors: colors,
                ),
                _Step4SetPricing(
                  initialBasePrice: basePrice.value,
                  initialPricePerKm: pricePerKm.value,
                  initialPricePerHour: pricePerHour.value,
                  initialMinPrice: minPrice.value,
                  onPricingChanged: (base, perKm, perHour, min) {
                    basePrice.value = base;
                    pricePerKm.value = perKm;
                    pricePerHour.value = perHour;
                    minPrice.value = min;
                  },
                  colors: colors,
                ),
                Obx(() => _Step5Preview(
                  category: selectedCategory,
                  service: selectedService,
                  title: titleText.value,
                  description: descriptionText.value,
                  images: selectedImages,
                  basePrice: basePrice.value,
                  pricePerKm: pricePerKm.value,
                  pricePerHour: pricePerHour.value,
                  minPrice: minPrice.value,
                  colors: colors,
                )),
              ],
            ),
          ),

          // Navigation buttons
          Obx(() => _NavigationButtons(
                currentStep: currentStep.value,
                onNext: nextStep,
                onPrevious: previousStep,
                onSubmit: submitService,
                canProceed: _canProceedToNextStep(),
                colors: colors,
                isLoading: controller.isLoading.value,
              )),
        ],
      ),
    );
  }

  bool _canProceedToNextStep() {
    switch (currentStep.value) {
      case 0:
        return selectedCategory != null && selectedService != null;
      case 1:
        // Title required (min 3 chars), description required (min 10 chars)
        return isTitleValid.value && isDescriptionValid.value;
      case 2:
        return true; // Images are optional
      case 3:
        return basePrice.value != null && basePrice.value! > 0;
      case 4:
        return true;
      default:
        return false;
    }
  }

  void _showDiscardDialog(AppColorScheme colors) {
    Get.dialog(
      AlertDialog(
        backgroundColor: colors.surface,
        title: Text(
          'driver.services.discard_title'.tr,
          style: AppTypography.headlineSmall(Get.context!).copyWith(color: colors.textPrimary),
        ),
        content: Text(
          'driver.services.discard_message'.tr,
          style: AppTypography.bodyMedium(Get.context!).copyWith(color: colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('common.cancel'.tr),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Close screen
            },
            style: TextButton.styleFrom(foregroundColor: colors.error),
            child: Text('common.discard'.tr),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// STEP INDICATOR
// ============================================================

class _StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final AppColorScheme colors;

  const _StepIndicator({
    required this.currentStep,
    required this.totalSteps,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      color: colors.surface,
      child: Row(
        children: List.generate(totalSteps, (index) {
          final isCompleted = index < currentStep;
          final isCurrent = index == currentStep;

          return Expanded(
            child: Container(
              height: 4.h,
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              decoration: BoxDecoration(
                color: isCompleted || isCurrent ? colors.primary : colors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ============================================================
// STEP 1: SELECT CATEGORY & SERVICE
// ============================================================

class _Step1SelectCategory extends StatefulWidget {
  final DriverServicesController controller;
  final AppColorScheme colors;
  final ServiceCategory? selectedCategory;
  final Service? selectedService;
  final Function(ServiceCategory) onCategorySelected;
  final Function(Service) onServiceSelected;

  const _Step1SelectCategory({
    required this.controller,
    required this.colors,
    required this.selectedCategory,
    required this.selectedService,
    required this.onCategorySelected,
    required this.onServiceSelected,
  });

  @override
  State<_Step1SelectCategory> createState() => _Step1SelectCategoryState();
}

class _Step1SelectCategoryState extends State<_Step1SelectCategory> {
  int? _expandedCategoryId;
  Map<int, List<Service>> _cachedServices = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'driver.services.step1_title'.tr,
            style: AppTypography.headlineMedium(context).copyWith(color: widget.colors.textPrimary),
          ),
          SizedBox(height: 8.h),
          Text(
            'driver.services.step1_subtitle'.tr,
            style: AppTypography.bodyMedium(context).copyWith(color: widget.colors.textSecondary),
          ),
          SizedBox(height: 24.h),

          // Professional Category Hierarchy with Expansion
          Obx(() {
            if (widget.controller.categories.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(40.h),
                  child: CircularProgressIndicator(color: widget.colors.primary),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.controller.categories.length,
              itemBuilder: (context, index) {
                final category = widget.controller.categories[index];
                final isExpanded = _expandedCategoryId == category.id;
                final hasServiceSelected = widget.selectedService?.categoryId == category.id;

                return _CategoryExpansionTile(
                  category: category,
                  colors: widget.colors,
                  isExpanded: isExpanded,
                  hasServiceSelected: hasServiceSelected,
                  selectedService: widget.selectedService,
                  cachedServices: _cachedServices[category.id!],
                  onExpand: () {
                    setState(() {
                      _expandedCategoryId = isExpanded ? null : category.id;
                    });
                    widget.onCategorySelected(category);
                    
                    // Load services if not cached
                    if (_cachedServices[category.id!] == null) {
                      widget.controller.loadServicesByCategory(category.id!).then((services) {
                        setState(() {
                          _cachedServices[category.id!] = services;
                        });
                      });
                    }
                  },
                  onServiceSelected: widget.onServiceSelected,
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

// Professional Expansion Tile for Categories
class _CategoryExpansionTile extends StatelessWidget {
  final ServiceCategory category;
  final AppColorScheme colors;
  final bool isExpanded;
  final bool hasServiceSelected;
  final Service? selectedService;
  final List<Service>? cachedServices;
  final VoidCallback onExpand;
  final Function(Service) onServiceSelected;

  const _CategoryExpansionTile({
    required this.category,
    required this.colors,
    required this.isExpanded,
    required this.hasServiceSelected,
    required this.selectedService,
    required this.cachedServices,
    required this.onExpand,
    required this.onServiceSelected,
  });

  IconData _getCategoryIcon(String iconName) {
    switch (iconName) {
      case 'car':
        return Iconsax.car;
      case 'local_shipping':
        return Iconsax.truck;
      case 'shopping_cart':
        return Iconsax.shopping_cart;
      case 'restaurant':
        return Iconsax.cake;
      case 'work':
        return Iconsax.briefcase;
      default:
        return Iconsax.box;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: isExpanded ? colors.primary.withOpacity(0.05) : colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: hasServiceSelected ? colors.primary : colors.border,
          width: hasServiceSelected ? 2 : 1,
        ),
        boxShadow: isExpanded
            ? [
                BoxShadow(
                  color: colors.primary.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ]
            : null,
      ),
      child: Column(
        children: [
          // Category Header
          InkWell(
            onTap: onExpand,
            borderRadius: BorderRadius.circular(16.r),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  // Icon
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: colors.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      _getCategoryIcon(category.icon),
                      color: colors.primary,
                      size: 28.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  
                  // Category Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.name,
                          style: AppTypography.bodyLarge(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                          ),
                        ),
                        if (category.description != null) ...[
                          SizedBox(height: 4.h),
                          Text(
                            category.description!,
                            style: AppTypography.bodySmall(context).copyWith(
                              color: colors.textSecondary,
                              fontSize: 13.sp,
                            ),
                            maxLines: isExpanded ? 3 : 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  // Status Indicator
                  SizedBox(width: 12.w),
                  if (hasServiceSelected && !isExpanded)
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: colors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    )
                  else
                    Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: colors.textSecondary,
                      size: 24.sp,
                    ),
                ],
              ),
            ),
          ),
          
          // Expanded Services List
          if (isExpanded) ...[
            Divider(height: 1, color: colors.border),
            _buildServicesList(context),
          ],
        ],
      ),
    );
  }

  Widget _buildServicesList(BuildContext context) {
    if (cachedServices == null) {
      return Padding(
        padding: EdgeInsets.all(24.w),
        child: Center(
          child: CircularProgressIndicator(
            color: colors.primary,
            strokeWidth: 2,
          ),
        ),
      );
    }

    if (cachedServices!.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(24.w),
        child: Center(
          child: Text(
            'No services available',
            style: AppTypography.bodyMedium(context).copyWith(
              color: colors.textSecondary,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
            child: Text(
              'Choose a service type:',
              style: AppTypography.bodySmall(context).copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                letterSpacing: 0.5,
              ),
            ),
          ),
          ...cachedServices!.map((service) => _buildServiceItem(context, service)),
        ],
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, Service service) {
    final isSelected = selectedService?.id == service.id;

    return GestureDetector(
      onTap: () => onServiceSelected(service),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary.withOpacity(0.15) : colors.background,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? colors.primary : colors.border.withOpacity(0.5),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Service Icon
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: isSelected 
                    ? colors.primary.withOpacity(0.2)
                    : colors.border.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Iconsax.box_1,
                color: isSelected ? colors.primary : colors.textSecondary,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            
            // Service Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.nameEn,
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: colors.textPrimary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 15.sp,
                    ),
                  ),
                  if (service.descriptionEn != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      service.descriptionEn!,
                      style: AppTypography.bodySmall(context).copyWith(
                        color: colors.textSecondary,
                        fontSize: 12.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (service.suggestedPriceMin != null && service.suggestedPriceMax != null) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Iconsax.wallet_money, size: 12.sp, color: colors.textSecondary.withOpacity(0.7)),
                        SizedBox(width: 4.w),
                        Text(
                          CurrencyHelper.formatRange(service.suggestedPriceMin!, service.suggestedPriceMax!),
                          style: AppTypography.bodySmall(context).copyWith(
                            color: colors.textSecondary.withOpacity(0.7),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            
            // Selection Indicator
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: colors.primary,
                size: 24.sp,
              )
            else
              Container(
                width: 24.sp,
                height: 24.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.border, width: 2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// STEP 2: ENTER DETAILS
// ============================================================

class _Step2EnterDetails extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final AppColorScheme colors;
  final RxBool isTitleValid;
  final RxBool isDescriptionValid;

  const _Step2EnterDetails({
    required this.titleController,
    required this.descriptionController,
    required this.colors,
    required this.isTitleValid,
    required this.isDescriptionValid,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'driver.services.step2_title'.tr,
            style: AppTypography.headlineMedium(context).copyWith(color: colors.textPrimary),
          ),
          SizedBox(height: 8.h),
          Text(
            'driver.services.step2_subtitle'.tr,
            style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
          ),
          SizedBox(height: 24.h),

          // Title
          Row(
            children: [
              Text(
                'driver.services.service_title'.tr,
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                ' *',
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Obx(() => TextField(
            controller: titleController,
            maxLength: 50,
            style: AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary),
            decoration: InputDecoration(
              hintText: 'driver.services.service_title_hint'.tr,
              helperText: 'Minimum 3 characters',
              helperStyle: AppTypography.bodySmall(context).copyWith(
                color: isTitleValid.value ? colors.success : colors.textSecondary,
              ),
              filled: true,
              fillColor: colors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: colors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: colors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: colors.primary, width: 2),
              ),
              suffixIcon: isTitleValid.value
                  ? Icon(Icons.check_circle, color: colors.success, size: 20.sp)
                  : null,
            ),
          )),

          SizedBox(height: 24.h),

          // Description
          Row(
            children: [
              Text(
                'driver.services.service_description'.tr,
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                ' *',
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Obx(() => TextField(
            controller: descriptionController,
            maxLength: 500,
            maxLines: 5,
            style: AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary),
            decoration: InputDecoration(
              hintText: 'driver.services.service_description_hint'.tr,
              helperText: 'Minimum 10 characters',
              helperStyle: AppTypography.bodySmall(context).copyWith(
                color: isDescriptionValid.value ? colors.success : colors.textSecondary,
              ),
              filled: true,
              fillColor: colors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: colors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: colors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: colors.primary, width: 2),
              ),
              suffixIcon: isDescriptionValid.value
                  ? Padding(
                      padding: EdgeInsets.only(top: 12.h, right: 12.w),
                      child: Icon(Icons.check_circle, color: colors.success, size: 20.sp),
                    )
                  : null,
            ),
          )),
        ],
      ),
    );
  }
}

// ============================================================
// STEP 3: UPLOAD IMAGES
// ============================================================

class _Step3UploadImages extends StatelessWidget {
  final RxList<File> selectedImages;
  final DriverServicesController controller;
  final AppColorScheme colors;

  const _Step3UploadImages({
    required this.selectedImages,
    required this.controller,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'driver.services.step3_title'.tr,
            style: AppTypography.headlineMedium(context).copyWith(color: colors.textPrimary),
          ),
          SizedBox(height: 8.h),
          Text(
            'driver.services.step3_subtitle'.tr,
            style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
          ),
          SizedBox(height: 24.h),

          // Upload button
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: OutlinedButton.icon(
              onPressed: () async {
                if (selectedImages.length >= 5) {
                  Get.snackbar('common.warning'.tr, 'driver.services.max_images_reached'.tr);
                  return;
                }
                final images = await controller.pickMultipleImages(maxImages: 5 - selectedImages.length);
                selectedImages.addAll(images);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: colors.primary, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              icon: Icon(Iconsax.gallery_add, color: colors.primary, size: 24.sp),
              label: Text(
                'driver.services.upload_images'.tr,
                style: AppTypography.bodyLarge(context).copyWith(color: colors.primary),
              ),
            ),
          ),

          // Image grid
          Obx(() {
            if (selectedImages.isEmpty) {
              return Container(
                margin: EdgeInsets.only(top: 24.h),
                padding: EdgeInsets.all(32.w),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colors.border, style: BorderStyle.solid),
                ),
                child: Column(
                  children: [
                    Icon(Iconsax.gallery, size: 48.sp, color: colors.textSecondary),
                    SizedBox(height: 12.h),
                    Text(
                      'driver.services.no_images_selected'.tr,
                      style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 24.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
              ),
              itemCount: selectedImages.length,
              itemBuilder: (context, index) {
                final image = selectedImages[index];
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.file(
                        image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: 4.w,
                      right: 4.w,
                      child: GestureDetector(
                        onTap: () => selectedImages.removeAt(index),
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: colors.error,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close, color: Colors.white, size: 16.sp),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

// ============================================================
// STEP 4: SET PRICING
// ============================================================

class _Step4SetPricing extends StatelessWidget {
  final double? initialBasePrice;
  final double? initialPricePerKm;
  final double? initialPricePerHour;
  final double? initialMinPrice;
  final Function(double?, double?, double?, double?) onPricingChanged;
  final AppColorScheme colors;

  const _Step4SetPricing({
    required this.initialBasePrice,
    required this.initialPricePerKm,
    required this.initialPricePerHour,
    required this.initialMinPrice,
    required this.onPricingChanged,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'driver.services.step4_title'.tr,
            style: AppTypography.headlineMedium(context).copyWith(color: colors.textPrimary),
          ),
          SizedBox(height: 8.h),
          Text(
            'driver.services.step4_subtitle'.tr,
            style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
          ),
          SizedBox(height: 24.h),

          // Pricing widget
          PricingConfigWidget(
            initialBasePrice: initialBasePrice,
            initialPricePerKm: initialPricePerKm,
            initialPricePerHour: initialPricePerHour,
            initialMinPrice: initialMinPrice,
            onPricingChanged: onPricingChanged,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// STEP 5: PREVIEW
// ============================================================

class _Step5Preview extends StatelessWidget {
  final ServiceCategory? category;
  final Service? service;
  final String title;
  final String description;
  final RxList<File> images;
  final double? basePrice;
  final double? pricePerKm;
  final double? pricePerHour;
  final double? minPrice;
  final AppColorScheme colors;

  const _Step5Preview({
    required this.category,
    required this.service,
    required this.title,
    required this.description,
    required this.images,
    required this.basePrice,
    required this.pricePerKm,
    required this.pricePerHour,
    required this.minPrice,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'driver.services.step5_title'.tr,
            style: AppTypography.headlineMedium(context).copyWith(color: colors.textPrimary),
          ),
          SizedBox(height: 8.h),
          Text(
            'driver.services.step5_subtitle'.tr,
            style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
          ),
          SizedBox(height: 24.h),

          // Preview card
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PreviewRow('Category', category?.name ?? '-', colors),
                _PreviewRow('Service', service?.nameEn ?? service?.descriptionEn ?? '-', colors),
                _PreviewRow('Title', title.isEmpty ? '-' : title, colors),
                _PreviewRow('Description', description.isEmpty ? '-' : description, colors),
                _PreviewRow('Images', '${images.length} image(s)', colors),
                _PreviewRow('Base Price', basePrice != null ? CurrencyHelper.format(basePrice!) : '-', colors),
                if (pricePerKm != null) _PreviewRow('Price/Km', '${CurrencyHelper.format(pricePerKm!)}/km', colors),
                if (pricePerHour != null) _PreviewRow('Price/Hour', '${CurrencyHelper.format(pricePerHour!)}/hr', colors),
                if (minPrice != null) _PreviewRow('Min Price', CurrencyHelper.format(minPrice!), colors),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewRow extends StatelessWidget {
  final String label;
  final String value;
  final AppColorScheme colors;

  const _PreviewRow(this.label, this.value, this.colors);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              label,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// NAVIGATION BUTTONS
// ============================================================

class _NavigationButtons extends StatelessWidget {
  final int currentStep;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onSubmit;
  final bool canProceed;
  final AppColorScheme colors;
  final bool isLoading;

  const _NavigationButtons({
    required this.currentStep,
    required this.onNext,
    required this.onPrevious,
    required this.onSubmit,
    required this.canProceed,
    required this.colors,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: onPrevious,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: colors.border),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'common.back'.tr,
                  style: AppTypography.bodyLarge(context).copyWith(color: colors.textPrimary),
                ),
              ),
            ),
          if (currentStep > 0) SizedBox(width: 12.w),
          Expanded(
            flex: currentStep == 0 ? 1 : 1,
            child: ElevatedButton(
              onPressed: canProceed
                  ? (currentStep == 4 ? onSubmit : onNext)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                disabledBackgroundColor: colors.border,
              ),
              child: isLoading
                  ? SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      currentStep == 4 ? 'common.submit'.tr : 'common.next'.tr,
                      style: AppTypography.bodyLarge(context).copyWith(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
