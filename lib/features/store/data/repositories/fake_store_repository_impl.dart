// lib/features/store/data/repositories/fake_store_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/store_entity.dart';
import '../../domain/repositories/store_repository.dart';

class FakeStoreRepositoryImpl implements StoreRepository {
  @override
  Future<Either<Failure, List<StoreEntity>>> getStores() async {
    // شبیه‌سازی تاخیر شبکه
    await Future.delayed(const Duration(seconds: 1));

    // ایجاد یک لیست ساختگی از فروشگاه‌ها با فیلدهای جدید
    final List<StoreEntity> fakeStores = [
      const StoreEntity(
        id: 1,
        name: 'فست فود آلفا',
        address: 'خیابان اصلی، پلاک ۱',
        isOpen: true,
        logoUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2rQ9Ryl-ju-wxVjyNg458bnF4cUPkEOUrb5m46K5P5hSWDS7rWV68CRHJ8uKxQO6MB2M&usqp=CAU',
        rating: 4.5,
        ratingCount: 250,
        cuisineType: 'فست فود',
        deliveryTimeEstimate: '۲۰-۳۰ دقیقه',
      ),
      const StoreEntity(
        id: 2,
        name: 'پیتزا بتا',
        address: 'میدان مرکزی',
        isOpen: false,
        logoUrl:
            'https://besazobechin.com/Files/Uploads/1399-12-6/1399-12-6-ad02b9e3-f5bb-490f-8543-2191cc706d50.webp',
        rating: 4.2,
        ratingCount: 180,
        cuisineType: 'پیتزا',
        deliveryTimeEstimate: '۳۰-۴۵ دقیقه',
      ),
      const StoreEntity(
        id: 3,
        name: 'کافه گاما',
        address: 'بلوار فرعی، کوچه ۳',
        isOpen: true,
        logoUrl: null, // تست لوگوی خالی
        rating: 4.8,
        ratingCount: 320,
        cuisineType: 'کافه',
        deliveryTimeEstimate: '۱۵-۲۵ دقیقه',
      ),
      const StoreEntity(
        id: 4,
        name: 'رستوران دلتا',
        address: 'خیابان انقلاب، پلاک ۴۵',
        isOpen: true,
        logoUrl:
            'https://besazobechin.com/Files/Uploads/1399-12-6/1399-12-6-ad02b9e3-f5bb-490f-8543-2191cc706d50.webp',
        rating: 4.0,
        ratingCount: 500,
        cuisineType: 'ایرانی',
        deliveryTimeEstimate: '۳۵-۵۰ دقیقه',
      ),
    ];

    return Right(fakeStores);
  }
}
