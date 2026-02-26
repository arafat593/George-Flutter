class ProductDetailsModel {
  final String id;
  final String name;
  final String description;
  final String shortDescription;
  final String material;
  final String dimensions;
  final double price;
  final int stockQuantity;
  final List<String> images;
  final String thumbnail;
  final double weight;
  final String color;
  final String size;
  final int? discountPrice;
  final String sku;
  final List<String> tags;
  final String? categoryId;
  final String slug;
  final String status;
  final bool isFeatured;
  final int viewCount;
  final int salesCount;
  final double averageRating;
  final int totalReviews;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.material,
    required this.dimensions,
    required this.price,
    required this.stockQuantity,
    required this.images,
    required this.thumbnail,
    required this.weight,
    required this.color,
    required this.size,
    this.discountPrice,
    required this.sku,
    required this.tags,
    this.categoryId,
    required this.slug,
    required this.status,
    required this.isFeatured,
    required this.viewCount,
    required this.salesCount,
    required this.averageRating,
    required this.totalReviews,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      material: json['material'] ?? '',
      dimensions: json['dimensions'] ?? '',
      price: json['price'] ?? 0,
      stockQuantity: json['stockQuantity'] ?? 0,
      images: List<String>.from(json['images'] ?? []),
      thumbnail: json['thumbnail'] ?? '',
      weight: (json['weight'] as num).toDouble(),
      color: json['color'] ?? '',
      size: json['size'] ?? '',
      discountPrice: json['discountPrice'],
      sku: json['sku'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      categoryId: json['categoryId'],
      slug: json['slug'] ?? '',
      status: json['status'] ?? '',
      isFeatured: json['isFeatured'] ?? false,
      viewCount: json['viewCount'] ?? 0,
      salesCount: json['salesCount'] ?? 0,
      averageRating: (json['averageRating'] as num).toDouble(),
      totalReviews: json['totalReviews'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "shortDescription": shortDescription,
      "material": material,
      "dimensions": dimensions,
      "price": price,
      "stockQuantity": stockQuantity,
      "images": images,
      "thumbnail": thumbnail,
      "weight": weight,
      "color": color,
      "size": size,
      "discountPrice": discountPrice,
      "sku": sku,
      "tags": tags,
      "categoryId": categoryId,
      "slug": slug,
      "status": status,
      "isFeatured": isFeatured,
      "viewCount": viewCount,
      "salesCount": salesCount,
      "averageRating": averageRating,
      "totalReviews": totalReviews,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}