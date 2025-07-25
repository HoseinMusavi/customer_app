// lib/features/promotion/data/repositories/fake_promotion_repository_impl.dart

import 'dart:math';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/promotion_entity.dart';
import '../../domain/repositories/promotion_repository.dart';

class FakePromotionRepositoryImpl implements PromotionRepository {
  // لیست URLهای تصاویر با کیفیت برای بنرهای تبلیغاتی
  final List<String> _promotionImageUrls = [
    'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=781&q=80',
    'https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1172&q=80',
    'https://images.unsplash.com/photo-1484723051597-6261513769e3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1476224203421-9ac39bcb3327?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=710&q=80',
    'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
  ];

  @override
  Future<Either<Failure, List<PromotionEntity>>> getPromotions() async {
    await Future.delayed(const Duration(milliseconds: 300));

    final random = Random();
    // از Set استفاده می‌کنیم تا مطمئن شویم عکس‌های تکراری در یک بار نمایش داده نمی‌شوند
    final Set<String> usedImages = {};

    // تولید 3 بنر تبلیغاتی با عکس‌های تصادفی و غیر تکراری
    final List<PromotionEntity> promotions = List.generate(3, (index) {
      String randomImageUrl;
      // این حلقه اطمینان می‌دهد که عکس انتخاب شده قبلا استفاده نشده باشد
      do {
        randomImageUrl =
            _promotionImageUrls[random.nextInt(_promotionImageUrls.length)];
      } while (usedImages.contains(randomImageUrl));

      usedImages.add(randomImageUrl);

      return PromotionEntity(id: index + 1, imageUrl: randomImageUrl);
    });

    return Right(promotions);
  }
}
