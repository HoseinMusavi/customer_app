// lib/features/store/domain/entities/store_entity.dart

import 'package:equatable/equatable.dart';

class StoreEntity extends Equatable {
  final int id;
  final String name;
  final String address;
  final String? logoUrl;
  final bool isOpen;
  final double rating; // امتیاز فروشگاه (مثلا: 4.5)
  final int ratingCount; // تعداد امتیاز دهندگان
  final String cuisineType; // نوع رستوران (مثلا: فست فود، ایرانی)
  final String deliveryTimeEstimate; // تخمین زمان ارسال (مثلا: ۲۵-۳۵ دقیقه)

  const StoreEntity({
    required this.id,
    required this.name,
    required this.address,
    this.logoUrl,
    required this.isOpen,
    required this.rating,
    required this.ratingCount,
    required this.cuisineType,
    required this.deliveryTimeEstimate,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    address,
    logoUrl,
    isOpen,
    rating,
    ratingCount,
    cuisineType,
    deliveryTimeEstimate,
  ];
}
