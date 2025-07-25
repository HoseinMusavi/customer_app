// lib/features/product/data/models/product_model.dart

import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.storeId,
    required super.storeName,
    required super.name,
    required super.description,
    required super.price,
    super.discountPrice,
    required super.imageUrl,
    required super.category,
    required super.isAvailable,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      storeId: json['store_id'],
      storeName: json['store_name'],
      name: json['name'],
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      discountPrice: (json['discount_price'] as num?)?.toDouble(),
      imageUrl: json['image_url'],
      category: json['category'],
      isAvailable: json['is_available'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'store_name': storeName,
      'name': name,
      'description': description,
      'price': price,
      'discount_price': discountPrice,
      'image_url': imageUrl,
      'category': category,
      'is_available': isAvailable,
    };
  }
}
