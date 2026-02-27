import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/elasticsearch/elasticsearch.dart';

/// Store Product management endpoint
/// Handles products and product categories for stores
/// All methods requiring userId take it as a parameter (decoded from token on client-side)
class StoreProductEndpoint extends Endpoint {
  // ==================== PRODUCT CATEGORIES ====================

  /// Create a product category
  Future<ProductCategory?> createProductCategory(
    Session session, {
    required int userId,
    required int storeId,
    required String name,
    String? imageUrl,
    int? displayOrder,
  }) async {
    try {
      // Verify store ownership
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        throw Exception('Store not found');
      }
      if (store.userId != userId) {
        throw Exception('Not authorized');
      }

      // Get next display order if not provided
      final existingCategories = await ProductCategory.db.find(
        session,
        where: (t) => t.storeId.equals(storeId),
      );
      final order = displayOrder ?? existingCategories.length + 1;

      final category = ProductCategory(
        storeId: storeId,
        name: name,
        imageUrl: imageUrl,
        displayOrder: order,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      return await ProductCategory.db.insertRow(session, category);
    } catch (e) {
      session.log('Error creating product category: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Get product categories for a store
  Future<List<ProductCategory>> getProductCategories(
    Session session, {
    required int storeId,
    bool activeOnly = true,
  }) async {
    try {
      if (activeOnly) {
        return await ProductCategory.db.find(
          session,
          where: (t) => t.storeId.equals(storeId) & t.isActive.equals(true),
          orderBy: (t) => t.displayOrder,
        );
      }

      return await ProductCategory.db.find(
        session,
        where: (t) => t.storeId.equals(storeId),
        orderBy: (t) => t.displayOrder,
      );
    } catch (e) {
      session.log('Error getting product categories: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Update a product category
  Future<ProductCategory?> updateProductCategory(
    Session session, {
    required int userId,
    required int categoryId,
    String? name,
    String? imageUrl,
    int? displayOrder,
  }) async {
    try {
      final category = await ProductCategory.db.findById(session, categoryId);
      if (category == null) {
        throw Exception('Category not found');
      }

      // Verify store ownership
      final store = await Store.db.findById(session, category.storeId);
      if (store == null || store.userId != userId) {
        throw Exception('Not authorized');
      }

      final updatedCategory = category.copyWith(
        name: name ?? category.name,
        imageUrl: imageUrl ?? category.imageUrl,
        displayOrder: displayOrder ?? category.displayOrder,
        updatedAt: DateTime.now(),
      );

      return await ProductCategory.db.updateRow(session, updatedCategory);
    } catch (e) {
      session.log('Error updating product category: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Toggle category active status
  Future<ProductCategory?> toggleCategoryActive(
    Session session, {
    required int userId,
    required int categoryId,
    required bool isActive,
  }) async {
    try {
      final category = await ProductCategory.db.findById(session, categoryId);
      if (category == null) {
        throw Exception('Category not found');
      }

      final store = await Store.db.findById(session, category.storeId);
      if (store == null || store.userId != userId) {
        throw Exception('Not authorized');
      }

      final updatedCategory = category.copyWith(
        isActive: isActive,
        updatedAt: DateTime.now(),
      );

      return await ProductCategory.db.updateRow(session, updatedCategory);
    } catch (e) {
      session.log('Error toggling category: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Delete a product category (soft delete by setting inactive)
  Future<bool> deleteProductCategory(
    Session session, {
    required int userId,
    required int categoryId,
  }) async {
    try {
      final category = await ProductCategory.db.findById(session, categoryId);
      if (category == null) {
        throw Exception('Category not found');
      }

      final store = await Store.db.findById(session, category.storeId);
      if (store == null || store.userId != userId) {
        throw Exception('Not authorized');
      }

      // Soft delete - set inactive
      final updatedCategory = category.copyWith(
        isActive: false,
        updatedAt: DateTime.now(),
      );
      await ProductCategory.db.updateRow(session, updatedCategory);

      // Also deactivate all products in this category
      final products = await StoreProduct.db.find(
        session,
        where: (t) => t.productCategoryId.equals(categoryId),
      );

      for (final product in products) {
        final updatedProduct = product.copyWith(
          isAvailable: false,
          updatedAt: DateTime.now(),
        );
        final result = await StoreProduct.db.updateRow(session, updatedProduct);
        // Sync to Elasticsearch
        await session.esSync.sync(result);
      }

      return true;
    } catch (e) {
      session.log('Error deleting category: $e', level: LogLevel.error);
      return false;
    }
  }

  // ==================== PRODUCTS ====================

  /// Add a new product
  Future<StoreProduct?> addProduct(
    Session session, {
    required int userId,
    required int storeId,
    int? productCategoryId,
    required String name,
    String? description,
    required double price,
    String? imageUrl,
    int? displayOrder,
  }) async {
    try {
      // Verify store ownership
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        throw Exception('Store not found');
      }
      if (store.userId != userId) {
        throw Exception('Not authorized');
      }

      // Validate category if provided
      if (productCategoryId != null) {
        final category = await ProductCategory.db.findById(session, productCategoryId);
        if (category == null || category.storeId != storeId) {
          throw Exception('Invalid product category');
        }
      }

      // Get next display order
      final existingProducts = await StoreProduct.db.find(
        session,
        where: (t) => t.storeId.equals(storeId),
      );
      final order = displayOrder ?? existingProducts.length + 1;

      final product = StoreProduct(
        storeId: storeId,
        productCategoryId: productCategoryId,
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
        displayOrder: order,
        isAvailable: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final createdProduct = await StoreProduct.db.insertRow(session, product);
      
      // Sync to Elasticsearch
      await session.esSync.indexProduct(createdProduct);
      
      session.log('Product created: ${createdProduct.id} for store $storeId');
      return createdProduct;
    } catch (e) {
      session.log('Error adding product: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Get products for a store
  Future<List<StoreProduct>> getProducts(
    Session session, {
    required int storeId,
    int? categoryId,
    bool availableOnly = true,
  }) async {
    try {
      if (categoryId != null) {
        if (availableOnly) {
          return await StoreProduct.db.find(
            session,
            where: (t) => 
              t.storeId.equals(storeId) & 
              t.productCategoryId.equals(categoryId) &
              t.isAvailable.equals(true),
            orderBy: (t) => t.displayOrder,
          );
        }
        return await StoreProduct.db.find(
          session,
          where: (t) => 
            t.storeId.equals(storeId) & 
            t.productCategoryId.equals(categoryId),
          orderBy: (t) => t.displayOrder,
        );
      }

      if (availableOnly) {
        return await StoreProduct.db.find(
          session,
          where: (t) => t.storeId.equals(storeId) & t.isAvailable.equals(true),
          orderBy: (t) => t.displayOrder,
        );
      }

      return await StoreProduct.db.find(
        session,
        where: (t) => t.storeId.equals(storeId),
        orderBy: (t) => t.displayOrder,
      );
    } catch (e) {
      session.log('Error getting products: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get product by ID
  Future<StoreProduct?> getProductById(Session session, int productId) async {
    try {
      return await StoreProduct.db.findById(session, productId);
    } catch (e) {
      session.log('Error getting product: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Update a product
  Future<StoreProduct?> updateProduct(
    Session session, {
    required int userId,
    required int productId,
    int? productCategoryId,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    int? displayOrder,
  }) async {
    try {
      final product = await StoreProduct.db.findById(session, productId);
      if (product == null) {
        throw Exception('Product not found');
      }

      // Verify store ownership
      final store = await Store.db.findById(session, product.storeId);
      if (store == null || store.userId != userId) {
        throw Exception('Not authorized');
      }

      // Validate new category if provided
      if (productCategoryId != null) {
        final category = await ProductCategory.db.findById(session, productCategoryId);
        if (category == null || category.storeId != product.storeId) {
          throw Exception('Invalid product category');
        }
      }

      final updatedProduct = product.copyWith(
        productCategoryId: productCategoryId ?? product.productCategoryId,
        name: name ?? product.name,
        description: description ?? product.description,
        price: price ?? product.price,
        imageUrl: imageUrl ?? product.imageUrl,
        displayOrder: displayOrder ?? product.displayOrder,
        updatedAt: DateTime.now(),
      );

      final result = await StoreProduct.db.updateRow(session, updatedProduct);
      
      // Sync to Elasticsearch
      await session.esSync.sync(result);
      
      return result;
    } catch (e) {
      session.log('Error updating product: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Toggle product availability
  Future<StoreProduct?> toggleProductAvailability(
    Session session, {
    required int userId,
    required int productId,
    required bool isAvailable,
  }) async {
    try {
      final product = await StoreProduct.db.findById(session, productId);
      if (product == null) {
        throw Exception('Product not found');
      }

      final store = await Store.db.findById(session, product.storeId);
      if (store == null || store.userId != userId) {
        throw Exception('Not authorized');
      }

      final updatedProduct = product.copyWith(
        isAvailable: isAvailable,
        updatedAt: DateTime.now(),
      );

      final result = await StoreProduct.db.updateRow(session, updatedProduct);
      
      // Sync to Elasticsearch
      await session.esSync.sync(result);
      
      return result;
    } catch (e) {
      session.log('Error toggling product: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Delete a product (soft delete)
  Future<bool> deleteProduct(
    Session session, {
    required int userId,
    required int productId,
  }) async {
    try {
      final product = await StoreProduct.db.findById(session, productId);
      if (product == null) {
        throw Exception('Product not found');
      }

      final store = await Store.db.findById(session, product.storeId);
      if (store == null || store.userId != userId) {
        throw Exception('Not authorized');
      }

      // Soft delete
      final updatedProduct = product.copyWith(
        isAvailable: false,
        updatedAt: DateTime.now(),
      );
      final result = await StoreProduct.db.updateRow(session, updatedProduct);
      
      // Sync to Elasticsearch (update with isAvailable=false)
      await session.esSync.sync(result);

      return true;
    } catch (e) {
      session.log('Error deleting product: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Reorder products
  Future<bool> reorderProducts(
    Session session, {
    required int userId,
    required int storeId,
    required List<int> productIds,
  }) async {
    try {
      final store = await Store.db.findById(session, storeId);
      if (store == null || store.userId != userId) {
        throw Exception('Not authorized');
      }

      for (int i = 0; i < productIds.length; i++) {
        final product = await StoreProduct.db.findById(session, productIds[i]);
        if (product != null && product.storeId == storeId) {
          final updatedProduct = product.copyWith(
            displayOrder: i + 1,
            updatedAt: DateTime.now(),
          );
          final result = await StoreProduct.db.updateRow(session, updatedProduct);
          // Sync to Elasticsearch
          await session.esSync.sync(result);
        }
      }

      return true;
    } catch (e) {
      session.log('Error reordering products: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Search products within a store
  Future<List<StoreProduct>> searchProducts(
    Session session, {
    required int storeId,
    required String query,
  }) async {
    try {
      final queryLower = query.toLowerCase();

      final products = await StoreProduct.db.find(
        session,
        where: (t) => t.storeId.equals(storeId) & t.isAvailable.equals(true),
      );

      return products.where((p) =>
        p.name.toLowerCase().contains(queryLower) ||
        (p.description?.toLowerCase().contains(queryLower) ?? false)
      ).toList();
    } catch (e) {
      session.log('Error searching products: $e', level: LogLevel.error);
      return [];
    }
  }
}
