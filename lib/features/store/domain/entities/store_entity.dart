// lib/features/store/domain/entities/store_entity.dart

import 'package:equatable/equatable.dart';

class StoreEntity extends Equatable {
  final int id;
  final String name;
  final String address;
  final String? logoUrl; // آدرس لوگو که می‌تواند وجود نداشته باشد
  final bool isOpen;

  const StoreEntity({
    required this.id,
    required this.name,
    required this.address,
    this.logoUrl,
    required this.isOpen,
  });

  @override
  List<Object?> get props => [id, name, address, logoUrl, isOpen];
}
