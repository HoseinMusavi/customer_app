// lib/features/store/data/models/store_model.dart

import '../../domain/entities/store_entity.dart';

class StoreModel extends StoreEntity {
  const StoreModel({
    required super.id,
    required super.name,
    required super.address,
    super.logoUrl,
    required super.isOpen,
  });

  /// یک Factory constructor که یک نقشه (Map) از نوع JSON را می‌گیرد
  /// و یک نمونه از StoreModel را برمی‌گرداند.
  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['store_id'], // بر اساس پروپوزال اولیه
      name: json['name'],
      address: json['address'],
      logoUrl: json['logo_url'],
      isOpen: json['is_open'],
    );
  }

  /// متدی که نمونه فعلی StoreModel را به یک نقشه (Map) از نوع JSON تبدیل می‌کند.
  Map<String, dynamic> toJson() {
    return {
      'store_id': id,
      'name': name,
      'address': address,
      'logo_url': logoUrl,
      'is_open': isOpen,
    };
  }
}
