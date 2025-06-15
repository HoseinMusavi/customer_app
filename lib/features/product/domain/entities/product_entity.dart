// lib/features/product/domain/entities/product_entity.dart

import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final int storeId;
  final String storeName;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const ProductEntity({
    required this.id,
    required this.storeId,
    required this.storeName,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
    id,
    storeId,
    storeName,
    name,
    description,
    price,
    imageUrl,
  ];
}
