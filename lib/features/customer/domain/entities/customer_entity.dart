// lib/features/customer/domain/entities/customer_entity.dart

import 'package:equatable/equatable.dart';
import 'address_entity.dart'; // ایمپورت آدرس

class CustomerEntity extends Equatable {
  final int id;
  final String fullName;
  final String email;
  final String phone;
  final String? avatarUrl;
  final List<AddressEntity> addresses; // لیست آدرس‌های مشتری
  final int? defaultAddressId; // شناسه آدرس پیش‌فرض

  const CustomerEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    this.avatarUrl,
    this.addresses = const [], // مقدار پیش‌فرض، لیست خالی
    this.defaultAddressId,
  });

  @override
  List<Object?> get props => [
    id,
    fullName,
    email,
    phone,
    avatarUrl,
    addresses,
    defaultAddressId,
  ];
}
