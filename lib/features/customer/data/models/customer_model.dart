// lib/features/customer/data/models/customer_model.dart

import '../../domain/entities/customer_entity.dart';

class CustomerModel extends CustomerEntity {
  const CustomerModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phone,
    super.avatarUrl,
  });

  /// یک Factory constructor که یک نقشه (Map) از نوع JSON را می‌گیرد
  /// و یک نمونه از CustomerModel را برمی‌گرداند.
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      avatarUrl: json['avatar_url'], // فرض می‌کنیم کلید در JSON به این شکل است
    );
  }

  /// متدی که نمونه فعلی CustomerModel را به یک نقشه (Map) از نوع JSON تبدیل می‌کند.
  /// این متد برای ارسال داده به سرور (مثلا در درخواست‌های POST یا PUT) کاربرد دارد.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'avatar_url': avatarUrl,
    };
  }
}
