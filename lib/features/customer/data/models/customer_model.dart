// lib/features/customer/data/models/customer_model.dart

import '../../domain/entities/customer_entity.dart';
import 'address_model.dart'; // ایمپورت مدل آدرس

class CustomerModel extends CustomerEntity {
  const CustomerModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phone,
    super.avatarUrl,
    required super.addresses,
    super.defaultAddressId,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    // تبدیل لیست جیسان آدرس‌ها به لیست مدل‌های آدرس
    var addressList = (json['addresses'] as List)
        .map((addressJson) => AddressModel.fromJson(addressJson))
        .toList();

    return CustomerModel(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      avatarUrl: json['avatar_url'],
      addresses: addressList,
      defaultAddressId: json['default_address_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'avatar_url': avatarUrl,
      // برای تبدیل به جیسون، مدل‌های آدرس را به جیسون تبدیل می‌کنیم
      'addresses': addresses
          .map((address) => (address as AddressModel).toJson())
          .toList(),
      'default_address_id': defaultAddressId,
    };
  }
}
