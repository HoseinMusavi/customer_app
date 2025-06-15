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
    required super.imageUrl,
  });

  /// یک Factory constructor که یک نقشه (Map) از نوع JSON را می‌گیرد
  /// و یک نمونه از ProductModel را برمی‌گرداند.
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      storeId: json['store_id'],
      storeName: json['store_name'],
      name: json['name'],
      description:
          json['description'] ?? '', // اگر توضیحات نداشت، رشته خالی در نظر بگیر
      price: (json['price'] as num).toDouble(), // برای اطمینان از نوع double
      imageUrl: json['image_url'],
    );
  }

  /// متدی که نمونه فعلی ProductModel را به یک نقشه (Map) از نوع JSON تبدیل می‌کند.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'store_name': storeName,
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
    };
  }
}
