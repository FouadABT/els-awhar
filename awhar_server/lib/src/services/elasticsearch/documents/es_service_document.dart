/// Elasticsearch document for services index
/// Maps Service data to ES document format with multi-language support
class EsServiceDocument {
  final int id;
  final int categoryId;
  final String? categoryName;
  final String nameEn;
  final String? nameAr;
  final String? nameFr;
  final String? nameEs;
  final String? descriptionEn;
  final String? descriptionAr;
  final String? descriptionFr;
  final String? descriptionEs;
  final String? iconName;
  final String? imageUrl;
  final double? suggestedPriceMin;
  final double? suggestedPriceMax;
  final bool isActive;
  final bool isPopular;
  final int displayOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  EsServiceDocument({
    required this.id,
    required this.categoryId,
    this.categoryName,
    required this.nameEn,
    this.nameAr,
    this.nameFr,
    this.nameEs,
    this.descriptionEn,
    this.descriptionAr,
    this.descriptionFr,
    this.descriptionEs,
    this.iconName,
    this.imageUrl,
    this.suggestedPriceMin,
    this.suggestedPriceMax,
    required this.isActive,
    required this.isPopular,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Convert to JSON for Elasticsearch
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'nameFr': nameFr,
      'nameEs': nameEs,
      'descriptionEn': descriptionEn,
      'descriptionAr': descriptionAr,
      'descriptionFr': descriptionFr,
      'descriptionEs': descriptionEs,
      'iconName': iconName,
      'imageUrl': imageUrl,
      'suggestedPriceMin': suggestedPriceMin,
      'suggestedPriceMax': suggestedPriceMax,
      'isActive': isActive,
      'isPopular': isPopular,
      'displayOrder': displayOrder,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      // Multi-language searchable text
      'searchableText': _buildSearchableText(),
      // ELSER semantic search field
      'semantic_description': _buildSemanticDescription(),
    };
  }

  String _buildSearchableText() {
    final parts = <String>[
      nameEn,
      if (nameAr != null) nameAr!,
      if (nameFr != null) nameFr!,
      if (nameEs != null) nameEs!,
      if (descriptionEn != null) descriptionEn!,
      if (descriptionAr != null) descriptionAr!,
      if (descriptionFr != null) descriptionFr!,
      if (descriptionEs != null) descriptionEs!,
      if (categoryName != null) categoryName!,
    ];
    return parts.join(' ');
  }

  /// Build rich semantic description for ELSER inference
  String _buildSemanticDescription() {
    final parts = <String>[
      nameEn,
      if (categoryName != null) 'Category: $categoryName',
      if (descriptionEn != null) descriptionEn!,
      if (descriptionFr != null) descriptionFr!,
      if (nameAr != null) nameAr!,
      if (suggestedPriceMin != null && suggestedPriceMax != null)
        'Price range: $suggestedPriceMin - $suggestedPriceMax MAD',
    ];
    return parts.join('. ');
  }

  /// Document ID for Elasticsearch
  String get documentId => 'service_$id';
}
