import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/currency_helper.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/store_controller.dart';
import '../../core/services/media_upload_service.dart';

/// Add/Edit product screen
class AddProductScreen extends StatefulWidget {
  final StoreProduct? product; // If provided, we're editing

  const AddProductScreen({super.key, this.product});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late final StoreController _storeController;
  late final MediaUploadService _mediaUploadService;
  
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  
  ProductCategory? _selectedCategory;
  String? _imageUrl;
  File? _selectedImage;
  bool _isAvailable = true;
  bool _isUploadingImage = false;

  bool get isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    _storeController = Get.find<StoreController>();
    _mediaUploadService = Get.find<MediaUploadService>();
    _initControllers();
  }

  void _initControllers() {
    final product = widget.product;
    _nameController = TextEditingController(text: product?.name ?? '');
    _descriptionController = TextEditingController(text: product?.description ?? '');
    _priceController = TextEditingController(
      text: product?.price.toStringAsFixed(2) ?? '',
    );
    _imageUrl = product?.imageUrl;
    _isAvailable = product?.isAvailable ?? true;
    
    // Find selected category
    if (product?.productCategoryId != null) {
      _selectedCategory = _storeController.productCategories
        .firstWhereOrNull((c) => c.id == product!.productCategoryId);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
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
          isEditing 
            ? 'store_products.edit_product'.tr 
            : 'store_products.add_product'.tr,
          style: AppTypography.titleMedium(context).copyWith(
            color: colors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              _buildImagePicker(colors),
              SizedBox(height: 24.h),
              
              // Product name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'store_products.product_name'.tr,
                  hintText: 'Enter product name',
                  prefixIcon: Icon(Iconsax.box),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  filled: true,
                  fillColor: colors.surface,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              
              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'store_products.product_description'.tr,
                  hintText: 'Enter product description',
                  prefixIcon: Icon(Iconsax.document_text),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  filled: true,
                  fillColor: colors.surface,
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16.h),
              
              // Price
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'store_products.product_price'.tr,
                  hintText: '0.00',
                  prefixIcon: Icon(Iconsax.money),
                  suffixText: CurrencyHelper.symbol,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  filled: true,
                  fillColor: colors.surface,
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  final price = double.tryParse(value);
                  if (price == null || price < 0) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              
              // Category dropdown
              _buildCategoryDropdown(colors),
              SizedBox(height: 16.h),
              
              // Availability toggle
              _buildAvailabilityToggle(colors),
              SizedBox(height: 32.h),
              
              // Save button
              Obx(() => SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: _storeController.isSaving.value ? null : _saveProduct,
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
                        isEditing ? 'common.save'.tr : 'store_products.add_product'.tr,
                        style: AppTypography.labelLarge(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ),
              )),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(dynamic colors) {
    return Center(
      child: GestureDetector(
        onTap: _isUploadingImage ? null : _pickImage,
        child: Container(
          width: 150.w,
          height: 150.w,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: colors.border),
          ),
          child: _isUploadingImage
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: colors.primary),
                    SizedBox(height: 8.h),
                    Text(
                      'Uploading...',
                      style: AppTypography.bodySmall(context).copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              )
            : _selectedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                  ),
                )
              : _imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: CachedNetworkImage(
                      imageUrl: _imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(color: colors.primary),
                      ),
                      errorWidget: (context, url, error) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.image,
                            size: 48.sp,
                            color: colors.textSecondary,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Error loading image',
                            style: AppTypography.bodySmall(context).copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.image,
                        size: 48.sp,
                        color: colors.textSecondary,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'store_products.product_image'.tr,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Tap to add',
                        style: AppTypography.labelSmall(context).copyWith(
                          color: colors.primary,
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown(dynamic colors) {
    return Obx(() {
      final categories = _storeController.productCategories;
      
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: colors.border),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<ProductCategory>(
            value: _selectedCategory,
            isExpanded: true,
            hint: Row(
              children: [
                Icon(Iconsax.category, color: colors.textSecondary, size: 20.sp),
                SizedBox(width: 12.w),
                Text(
                  'store_products.select_category'.tr,
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
            items: [
              DropdownMenuItem<ProductCategory>(
                value: null,
                child: Text(
                  'No category',
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ),
              ...categories.map((category) => DropdownMenuItem<ProductCategory>(
                value: category,
                child: Text(
                  category.name,
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textPrimary,
                  ),
                ),
              )),
            ],
            onChanged: (value) {
              setState(() => _selectedCategory = value);
            },
          ),
        ),
      );
    });
  }

  Widget _buildAvailabilityToggle(dynamic colors) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            _isAvailable ? Iconsax.tick_circle : Iconsax.close_circle,
            color: _isAvailable ? Colors.green : Colors.red,
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isAvailable 
                    ? 'store_products.available'.tr 
                    : 'store_products.unavailable'.tr,
                  style: AppTypography.labelLarge(context).copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                Text(
                  _isAvailable 
                    ? 'Product is visible to customers' 
                    : 'Product is hidden from customers',
                  style: AppTypography.bodySmall(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: _isAvailable,
            onChanged: (value) {
              setState(() => _isAvailable = value);
            },
            activeTrackColor: colors.primary.withValues(alpha: 0.4),
            thumbColor: MaterialStateProperty.all(colors.primary),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    
    final source = await Get.bottomSheet<ImageSource>(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Iconsax.camera),
              title: const Text('Camera'),
              onTap: () => Get.back(result: ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Iconsax.gallery),
              title: const Text('Gallery'),
              onTap: () => Get.back(result: ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    }
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    final price = double.parse(_priceController.text);

    // Upload image if selected
    String? imageUrl = _imageUrl;
    if (_selectedImage != null) {
      setState(() => _isUploadingImage = true);
      
      try {
        // Use store ID as requestId for organizing uploads
        final requestId = 'store_${_storeController.storeId}';
        
        final uploadResult = await _mediaUploadService.uploadImage(
          imageFile: _selectedImage!,
          requestId: requestId,
        );
        
        if (uploadResult != null && uploadResult['imageUrl'] != null) {
          imageUrl = uploadResult['imageUrl'];
          debugPrint('✅ Image uploaded successfully: $imageUrl');
        } else {
          setState(() => _isUploadingImage = false);
          Get.snackbar(
            'common.error'.tr,
            'Failed to upload image',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }
      } catch (e) {
        debugPrint('❌ Error uploading image: $e');
        setState(() => _isUploadingImage = false);
        Get.snackbar(
          'common.error'.tr,
          'Failed to upload image: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      } finally {
        setState(() => _isUploadingImage = false);
      }
    }

    bool success;
    if (isEditing) {
      success = await _storeController.updateProduct(
        productId: widget.product!.id!,
        productCategoryId: _selectedCategory?.id,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isNotEmpty 
          ? _descriptionController.text.trim() 
          : null,
        price: price,
        imageUrl: imageUrl,
      );
    } else {
      final product = await _storeController.addProduct(
        productCategoryId: _selectedCategory?.id,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isNotEmpty 
          ? _descriptionController.text.trim() 
          : null,
        price: price,
        imageUrl: imageUrl,
      );
      success = product != null;
    }

    if (success) {
      Get.back();
      Get.snackbar(
        'common.success'.tr,
        isEditing 
          ? 'store_products.product_updated'.tr 
          : 'store_products.product_added'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
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
