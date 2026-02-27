import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:awhar_client/awhar_client.dart';
import 'auth_controller.dart';

/// Store management controller
/// Handles store registration, profile, products, and orders
class StoreController extends GetxController {
  late final Client _client;
  late final AuthController _authController;

  /// Get current user ID
  int? get _userId => _authController.currentUser.value?.id;

  // ============================================================
  // OBSERVABLE STATE
  // ============================================================

  /// Current store (owned by logged-in user)
  final Rx<Store?> myStore = Rx<Store?>(null);

  /// Store categories for registration
  final RxList<StoreCategory> storeCategories = <StoreCategory>[].obs;

  /// Product categories for the store
  final RxList<ProductCategory> productCategories = <ProductCategory>[].obs;

  /// Products for the store
  final RxList<StoreProduct> products = <StoreProduct>[].obs;

  /// Loading states
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;
  final RxBool isLoadingProducts = false.obs;

  /// Error message
  final RxString errorMessage = ''.obs;

  /// Success message
  final RxString successMessage = ''.obs;

  /// Selected store category during registration
  final Rx<StoreCategory?> selectedCategory = Rx<StoreCategory?>(null);

  // ============================================================
  // GETTERS
  // ============================================================

  /// Whether user has a store
  bool get hasStore => myStore.value != null;

  /// Whether store is open
  bool get isStoreOpen => myStore.value?.isOpen ?? false;

  /// Whether store is active
  bool get isStoreActive => myStore.value?.isActive ?? false;

  /// Store ID
  int? get storeId => myStore.value?.id;

  // ============================================================
  // LIFECYCLE
  // ============================================================

  @override
  void onInit() {
    super.onInit();
    _client = Get.find<Client>();
    _authController = Get.find<AuthController>();
  }

  @override
  void onReady() {
    super.onReady();
    loadStoreCategories();
    loadMyStore();
  }

  // ============================================================
  // STORE CATEGORIES
  // ============================================================

  /// Load available store categories
  Future<void> loadStoreCategories() async {
    try {
      final categories = await _client.store.getStoreCategories();
      storeCategories.assignAll(categories);
    } catch (e) {
      debugPrint('[StoreController] Error loading categories: $e');
    }
  }

  // ============================================================
  // STORE MANAGEMENT
  // ============================================================

  /// Load current user's store
  Future<void> loadMyStore() async {
    if (_userId == null) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final store = await _client.store.getMyStore(userId: _userId!);
      myStore.value = store;

      if (store != null) {
        // Load product categories and products
        await loadProductCategories();
        await loadProducts();
      }
    } catch (e) {
      debugPrint('[StoreController] Error loading store: $e');
      errorMessage.value = 'Failed to load store';
    } finally {
      isLoading.value = false;
    }
  }

  /// Create a new store
  Future<bool> createStore({
    required int storeCategoryId,
    required String name,
    String? description,
    required String phone,
    String? email,
    required String address,
    required double latitude,
    required double longitude,
    String? city,
    double? deliveryRadiusKm,
  }) async {
    try {
      isSaving.value = true;
      errorMessage.value = '';

      if (_userId == null) {
        throw Exception('User not authenticated');
      }

      final store = await _client.store.createStore(
        userId: _userId!,
        storeCategoryId: storeCategoryId,
        name: name,
        description: description,
        phone: phone,
        email: email,
        address: address,
        latitude: latitude,
        longitude: longitude,
        city: city,
        deliveryRadiusKm: deliveryRadiusKm,
      );

      if (store != null) {
        myStore.value = store;
        successMessage.value = 'store_management.create_store_success'.tr;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreController] Error creating store: $e');
      errorMessage.value = e.toString();
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  /// Update store profile
  Future<bool> updateStore({
    String? name,
    String? description,
    String? phone,
    String? email,
    String? address,
    double? latitude,
    double? longitude,
    String? city,
    double? deliveryRadiusKm,
    double? minimumOrderAmount,
    int? estimatedPrepTimeMinutes,
  }) async {
    if (storeId == null || _userId == null) return false;

    try {
      isSaving.value = true;
      errorMessage.value = '';

      final updatedStore = await _client.store.updateStore(
        userId: _userId!,
        storeId: storeId!,
        name: name,
        description: description,
        phone: phone,
        email: email,
        address: address,
        latitude: latitude,
        longitude: longitude,
        city: city,
        deliveryRadiusKm: deliveryRadiusKm,
        minimumOrderAmount: minimumOrderAmount,
        estimatedPrepTimeMinutes: estimatedPrepTimeMinutes,
      );

      if (updatedStore != null) {
        myStore.value = updatedStore;
        successMessage.value = 'store_management.update_store_success'.tr;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreController] Error updating store: $e');
      errorMessage.value = e.toString();
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  /// Update store with extended profile fields
  Future<bool> updateStoreExtended({
    String? name,
    String? description,
    String? phone,
    String? email,
    String? address,
    double? latitude,
    double? longitude,
    String? city,
    double? deliveryRadiusKm,
    double? minimumOrderAmount,
    int? estimatedPrepTimeMinutes,
    // Extended profile fields
    String? tagline,
    String? aboutText,
    String? whatsappNumber,
    String? websiteUrl,
    String? facebookUrl,
    String? instagramUrl,
    bool? acceptsCash,
    bool? acceptsCard,
    bool? hasDelivery,
    bool? hasPickup,
  }) async {
    if (storeId == null || _userId == null) return false;

    try {
      isSaving.value = true;
      errorMessage.value = '';

      // First update basic store info
      var updatedStore = await _client.store.updateStore(
        userId: _userId!,
        storeId: storeId!,
        name: name,
        description: description,
        phone: phone,
        email: email,
        address: address,
        latitude: latitude,
        longitude: longitude,
        city: city,
        deliveryRadiusKm: deliveryRadiusKm,
        minimumOrderAmount: minimumOrderAmount,
        estimatedPrepTimeMinutes: estimatedPrepTimeMinutes,
      );

      // Then update extended profile
      updatedStore = await _client.store.updateStoreExtendedProfile(
        userId: _userId!,
        storeId: storeId!,
        tagline: tagline,
        aboutText: aboutText,
        whatsappNumber: whatsappNumber,
        websiteUrl: websiteUrl,
        facebookUrl: facebookUrl,
        instagramUrl: instagramUrl,
        acceptsCash: acceptsCash,
        acceptsCard: acceptsCard,
        hasDelivery: hasDelivery,
        hasPickup: hasPickup,
      );

      if (updatedStore != null) {
        myStore.value = updatedStore;
        successMessage.value = 'store_management.update_store_success'.tr;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreController] Error updating store extended: $e');
      errorMessage.value = e.toString();
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  /// Toggle store open/closed
  Future<bool> toggleStoreOpen() async {
    if (storeId == null || _userId == null) return false;

    try {
      final newStatus = !isStoreOpen;
      final updatedStore = await _client.store.toggleStoreOpen(
        userId: _userId!,
        storeId: storeId!,
        isOpen: newStatus,
      );

      if (updatedStore != null) {
        myStore.value = updatedStore;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreController] Error toggling store: $e');
      errorMessage.value = e.toString();
      return false;
    }
  }

  /// Set working hours
  Future<bool> setWorkingHours(String workingHoursJson) async {
    if (storeId == null || _userId == null) return false;

    try {
      final updatedStore = await _client.store.setWorkingHours(
        userId: _userId!,
        storeId: storeId!,
        workingHoursJson: workingHoursJson,
      );

      if (updatedStore != null) {
        myStore.value = updatedStore;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreController] Error setting hours: $e');
      errorMessage.value = e.toString();
      return false;
    }
  }

  /// Update store logo
  Future<bool> updateStoreLogo(String logoUrl) async {
    if (storeId == null || _userId == null) return false;

    try {
      final updatedStore = await _client.store.updateStoreLogo(
        userId: _userId!,
        storeId: storeId!,
        logoUrl: logoUrl,
      );

      if (updatedStore != null) {
        myStore.value = updatedStore;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreController] Error updating logo: $e');
      return false;
    }
  }

  /// Update store cover image
  Future<bool> updateStoreCoverImage(String coverUrl) async {
    if (storeId == null || _userId == null) return false;

    try {
      final updatedStore = await _client.store.updateStoreCoverImage(
        userId: _userId!,
        storeId: storeId!,
        coverImageUrl: coverUrl,
      );

      if (updatedStore != null) {
        myStore.value = updatedStore;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreController] Error updating cover: $e');
      return false;
    }
  }

  // ============================================================
  // PRODUCT CATEGORIES
  // ============================================================

  /// Load product categories for the store
  Future<void> loadProductCategories() async {
    if (storeId == null) return;

    try {
      final categories = await _client.storeProduct.getProductCategories(
        storeId: storeId!,
        activeOnly: false,
      );
      productCategories.assignAll(categories);
    } catch (e) {
      debugPrint('[StoreController] Error loading product categories: $e');
    }
  }

  /// Create a product category
  Future<ProductCategory?> createProductCategory({
    required String name,
    String? imageUrl,
  }) async {
    if (storeId == null || _userId == null) return null;

    try {
      isSaving.value = true;

      final category = await _client.storeProduct.createProductCategory(
        userId: _userId!,
        storeId: storeId!,
        name: name,
        imageUrl: imageUrl,
      );

      if (category != null) {
        productCategories.add(category);
      }
      return category;
    } catch (e) {
      debugPrint('[StoreController] Error creating category: $e');
      errorMessage.value = e.toString();
      return null;
    } finally {
      isSaving.value = false;
    }
  }

  /// Update a product category
  Future<bool> updateProductCategory({
    required int categoryId,
    String? name,
    String? imageUrl,
  }) async {
    if (_userId == null) return false;

    try {
      isSaving.value = true;

      final updated = await _client.storeProduct.updateProductCategory(
        userId: _userId!,
        categoryId: categoryId,
        name: name,
        imageUrl: imageUrl,
      );

      if (updated != null) {
        final index = productCategories.indexWhere((c) => c.id == categoryId);
        if (index >= 0) {
          productCategories[index] = updated;
        }
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreController] Error updating category: $e');
      errorMessage.value = e.toString();
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  /// Delete a product category
  Future<bool> deleteProductCategory(int categoryId) async {
    if (_userId == null) return false;

    try {
      final success = await _client.storeProduct.deleteProductCategory(
        userId: _userId!,
        categoryId: categoryId,
      );

      if (success) {
        productCategories.removeWhere((c) => c.id == categoryId);
        // Reload products as some may have been deactivated
        await loadProducts();
      }
      return success;
    } catch (e) {
      debugPrint('[StoreController] Error deleting category: $e');
      return false;
    }
  }

  // ============================================================
  // PRODUCTS
  // ============================================================

  /// Load products for the store
  Future<void> loadProducts({int? categoryId, bool availableOnly = false}) async {
    if (storeId == null) return;

    try {
      isLoadingProducts.value = true;

      final productList = await _client.storeProduct.getProducts(
        storeId: storeId!,
        categoryId: categoryId,
        availableOnly: availableOnly,
      );
      products.assignAll(productList);
    } catch (e) {
      debugPrint('[StoreController] Error loading products: $e');
    } finally {
      isLoadingProducts.value = false;
    }
  }

  /// Add a new product
  Future<StoreProduct?> addProduct({
    int? productCategoryId,
    required String name,
    String? description,
    required double price,
    String? imageUrl,
  }) async {
    if (storeId == null || _userId == null) return null;

    try {
      isSaving.value = true;

      final product = await _client.storeProduct.addProduct(
        userId: _userId!,
        storeId: storeId!,
        productCategoryId: productCategoryId,
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
      );

      if (product != null) {
        products.add(product);
        successMessage.value = 'store_products.product_added'.tr;
      }
      return product;
    } catch (e) {
      debugPrint('[StoreController] Error adding product: $e');
      errorMessage.value = e.toString();
      return null;
    } finally {
      isSaving.value = false;
    }
  }

  /// Update a product
  Future<bool> updateProduct({
    required int productId,
    int? productCategoryId,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
  }) async {
    if (_userId == null) return false;

    try {
      isSaving.value = true;

      final updated = await _client.storeProduct.updateProduct(
        userId: _userId!,
        productId: productId,
        productCategoryId: productCategoryId,
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
      );

      if (updated != null) {
        final index = products.indexWhere((p) => p.id == productId);
        if (index >= 0) {
          products[index] = updated;
        }
        successMessage.value = 'store_products.product_updated'.tr;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreController] Error updating product: $e');
      errorMessage.value = e.toString();
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  /// Toggle product availability
  Future<bool> toggleProductAvailability(int productId) async {
    if (_userId == null) return false;

    try {
      final product = products.firstWhereOrNull((p) => p.id == productId);
      if (product == null) return false;

      final updated = await _client.storeProduct.toggleProductAvailability(
        userId: _userId!,
        productId: productId,
        isAvailable: !product.isAvailable,
      );

      if (updated != null) {
        final index = products.indexWhere((p) => p.id == productId);
        if (index >= 0) {
          products[index] = updated;
        }
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreController] Error toggling product: $e');
      return false;
    }
  }

  /// Delete a product
  Future<bool> deleteProduct(int productId) async {
    if (_userId == null) return false;

    try {
      final success = await _client.storeProduct.deleteProduct(
        userId: _userId!,
        productId: productId,
      );

      if (success) {
        products.removeWhere((p) => p.id == productId);
        successMessage.value = 'store_products.product_deleted'.tr;
      }
      return success;
    } catch (e) {
      debugPrint('[StoreController] Error deleting product: $e');
      return false;
    }
  }

  /// Search products
  Future<List<StoreProduct>> searchProducts(String query) async {
    if (storeId == null) return [];

    try {
      return await _client.storeProduct.searchProducts(
        storeId: storeId!,
        query: query,
      );
    } catch (e) {
      debugPrint('[StoreController] Error searching products: $e');
      return [];
    }
  }

  // ============================================================
  // HELPERS
  // ============================================================

  /// Clear error message
  void clearError() {
    errorMessage.value = '';
  }

  /// Clear success message
  void clearSuccess() {
    successMessage.value = '';
  }

  /// Refresh all data
    @override
  Future<void> refresh() async {
    await loadMyStore();
  }
}
