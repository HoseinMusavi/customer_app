// lib/features/store/data/models/store_model.dart

import '../../domain/entities/store_entity.dart';

class StoreModel extends StoreEntity {
  const StoreModel({
    required super.id,
    required super.name,
    required super.address,
    super.logoUrl,
    required super.isOpen,
    required super.rating,
    required super.ratingCount,
    required super.cuisineType,
    required super.deliveryTimeEstimate,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['store_id'],
      name: json['name'],
      address: json['address'],
      logoUrl: json['logo_url'],
      isOpen: json['is_open'],
      rating: (json['rating'] as num).toDouble(),
      ratingCount: json['rating_count'],
      cuisineType: json['cuisine_type'],
      deliveryTimeEstimate: json['delivery_time_estimate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'store_id': id,
      'name': name,
      'address': address,
      'logo_url': logoUrl,
      'is_open': isOpen,
      'rating': rating,
      'rating_count': ratingCount,
      'cuisine_type': cuisineType,
      'delivery_time_estimate': deliveryTimeEstimate,
    };
  }
}
