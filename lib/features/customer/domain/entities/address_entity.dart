// lib/features/customer/domain/entities/address_entity.dart
import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final int id;
  final String title; // مثلا: خانه، محل کار
  final String fullAddress; // آدرس کامل متنی
  final String postalCode;
  final String city;

  const AddressEntity({
    required this.id,
    required this.title,
    required this.fullAddress,
    required this.postalCode,
    required this.city,
  });

  @override
  List<Object?> get props => [id, title, fullAddress, postalCode, city];
}
