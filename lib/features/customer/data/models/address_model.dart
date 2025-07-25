// lib/features/customer/data/models/address_model.dart
import '../../domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.id,
    required super.title,
    required super.fullAddress,
    required super.postalCode,
    required super.city,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      title: json['title'],
      fullAddress: json['full_address'],
      postalCode: json['postal_code'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'full_address': fullAddress,
      'postal_code': postalCode,
      'city': city,
    };
  }
}
