// lib/features/promotion/domain/entities/promotion_entity.dart
import 'package:equatable/equatable.dart';

class PromotionEntity extends Equatable {
  final int id;
  final String imageUrl;
  final String? storeId; // برای لینک دادن به یک فروشگاه خاص (اختیاری)

  const PromotionEntity({
    required this.id,
    required this.imageUrl,
    this.storeId,
  });

  @override
  List<Object?> get props => [id, imageUrl, storeId];
}
