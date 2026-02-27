import 'package:get/get.dart';
import 'package:awhar_client/awhar_client.dart';
import 'dart:convert';

/// Cart item model for local cart management
class CartItem {
  final int productId;
  final String name;
  final double price;
  final String? imageUrl;
  int quantity;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    this.imageUrl,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'name': name,
    'price': price,
    'imageUrl': imageUrl,
    'quantity': quantity,
  };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    productId: json['productId'] as int,
    name: json['name'] as String,
    price: (json['price'] as num).toDouble(),
    imageUrl: json['imageUrl'] as String?,
    quantity: json['quantity'] as int,
  );

  factory CartItem.fromProduct(StoreProduct product) => CartItem(
    productId: product.id!,
    name: product.name,
    price: product.price,
    imageUrl: product.imageUrl,
  );
}

/// Cart controller for managing shopping cart
class CartController extends GetxController {
  static CartController get to => Get.find<CartController>();

  // Cart items
  final RxList<CartItem> items = <CartItem>[].obs;

  // Current store info
  final RxInt currentStoreId = 0.obs;
  final RxString currentStoreName = ''.obs;
  final RxDouble storeMinimumOrder = 0.0.obs;

  // Delivery info
  final RxDouble deliveryFee = 0.0.obs;
  final RxDouble deliveryDistance = 0.0.obs;

  // Notes
  final RxString orderNotes = ''.obs;

  // Computed values
  double get subtotal => items.fold(0.0, (sum, item) => sum + item.totalPrice);

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  double get total => subtotal + deliveryFee.value;

  bool get meetsMinimumOrder => subtotal >= storeMinimumOrder.value;

  bool get isEmpty => items.isEmpty;

  bool get isNotEmpty => items.isNotEmpty;

  /// Set current store for the cart
  void setStore(Store store) {
    // If switching to a different store, clear the cart
    if (currentStoreId.value != 0 && currentStoreId.value != store.id) {
      clearCart();
    }

    currentStoreId.value = store.id!;
    currentStoreName.value = store.name;
    storeMinimumOrder.value = store.minimumOrderAmount ?? 0.0;
  }

  /// Add item to cart
  void addItem(StoreProduct product) {
    final existingIndex = items.indexWhere((item) => item.productId == product.id);

    if (existingIndex != -1) {
      items[existingIndex].quantity++;
      items.refresh();
    } else {
      items.add(CartItem.fromProduct(product));
    }
  }

  /// Remove item from cart
  void removeItem(int productId) {
    items.removeWhere((item) => item.productId == productId);
  }

  /// Get quantity of a specific product in cart
  int getItemQuantity(int productId) {
    final item = items.firstWhereOrNull((item) => item.productId == productId);
    return item?.quantity ?? 0;
  }

  /// Increase quantity of an item
  void increaseQuantity(int productId) {
    final index = items.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      items[index].quantity++;
      items.refresh();
    }
  }

  /// Decrease quantity of an item
  void decreaseQuantity(int productId) {
    final index = items.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      if (items[index].quantity > 1) {
        items[index].quantity--;
        items.refresh();
      } else {
        items.removeAt(index);
      }
    }
  }

  /// Update item quantity directly
  void updateQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      removeItem(productId);
      return;
    }

    final index = items.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      items[index].quantity = quantity;
      items.refresh();
    }
  }

  /// Clear all items from cart
  void clearCart() {
    items.clear();
    currentStoreId.value = 0;
    currentStoreName.value = '';
    storeMinimumOrder.value = 0.0;
    deliveryFee.value = 0.0;
    deliveryDistance.value = 0.0;
    orderNotes.value = '';
  }

  /// Set delivery fee based on distance
  void calculateDeliveryFee(double distanceKm) {
    deliveryDistance.value = distanceKm;
    // Base fee of 10 MAD + 3 MAD per km
    deliveryFee.value = 10.0 + (distanceKm * 3.0);
  }

  /// Set order notes
  void setOrderNotes(String notes) {
    orderNotes.value = notes;
  }

  /// Convert cart items to JSON string for order
  String get itemsJson {
    final itemsList = items.map((item) => item.toJson()).toList();
    return jsonEncode(itemsList);
  }

  /// Get items list for API call (List of OrderItem)
  List<OrderItem> getItemsForApi() {
    return items.map((item) => OrderItem(
      productId: item.productId,
      quantity: item.quantity,
      notes: null, // Notes per item not currently supported
    )).toList();
  }

  /// Get cart summary for display
  Map<String, dynamic> get cartSummary => {
    'storeId': currentStoreId.value,
    'storeName': currentStoreName.value,
    'itemCount': totalItems,
    'subtotal': subtotal,
    'deliveryFee': deliveryFee.value,
    'total': total,
    'meetsMinimum': meetsMinimumOrder,
    'minimumOrder': storeMinimumOrder.value,
  };
}
