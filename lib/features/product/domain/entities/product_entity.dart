// lib/features/product/domain/entities/product_entity.dart

import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final int storeId;
  final String storeName;
  final String name;
  final String description;
  final double price;
  final double? discountPrice; // قیمت با تخفیف که می‌تواند وجود نداشته باشد
  final String imageUrl;
  final String category; // دسته‌بندی محصول (مثلا: پیتزا، ساندویچ)
  final bool isAvailable; // وضعیت موجودی

  const ProductEntity({
    required this.id,
    required this.storeId,
    required this.storeName,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.imageUrl,
    required this.category,
    required this.isAvailable,
  });

  // یک getter برای نمایش قیمت نهایی (با تخفیف یا بدون تخفیف)
  double get finalPrice => discountPrice ?? price;

  @override
  List<Object?> get props => [
    id,
    storeId,
    storeName,
    name,
    description,
    price,
    discountPrice,
    imageUrl,
    category,
    isAvailable,
  ];
}
