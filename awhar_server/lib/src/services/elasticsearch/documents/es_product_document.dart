/// Elasticsearch document for products index
/// Maps StoreProduct data for product search
class EsProductDocument {
  final int id;
  final int storeId;
  final int? productCategoryId;
  
  // Store info (denormalized)
  final String? storeName;
  final String? storeLogoUrl;
  final Map<String, double>? storeLocation;
  
  // Product info
  final String name;
  final String? description;
  final double price;
  final String? imageUrl;
  final String? categoryName;
  
  // Status
  final bool isAvailable;
  final int displayOrder;
  
  final DateTime createdAt;
  final DateTime updatedAt;

  EsProductDocument({
    required this.id,
    required this.storeId,
    this.productCategoryId,
    this.storeName,
    this.storeLogoUrl,
    this.storeLocation,
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
    this.categoryName,
    required this.isAvailable,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storeId': storeId,
      'productCategoryId': productCategoryId,
      'storeName': storeName,
      'storeLogoUrl': storeLogoUrl,
      'storeLocation': storeLocation,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'categoryName': categoryName,
      'isAvailable': isAvailable,
      'displayOrder': displayOrder,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'searchableText': _buildSearchableText(),
      // ELSER semantic search field
      'semantic_description': _buildSemanticDescription(),
    };
  }

  String _buildSearchableText() {
    final parts = <String>[
      name,
      if (description != null) description!,
      if (categoryName != null) categoryName!,
      if (storeName != null) storeName!,
    ];
    return parts.join(' ');
  }

  /// Build rich semantic description for ELSER inference
  String _buildSemanticDescription() {
    final parts = <String>[
      name,
      if (description != null) description!,
      if (categoryName != null) 'Category: $categoryName',
      if (storeName != null) 'Sold at $storeName',
      'Price: $price MAD',
    ];
    return parts.join('. ');
  }

  String get documentId => 'product_$id';
}
