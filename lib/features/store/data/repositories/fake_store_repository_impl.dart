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

    // ایجاد یک لیست ساختگی از فروشگاه‌ها
    final List<StoreEntity> fakeStores = [
      const StoreEntity(
        id: 1,
        name: 'فست فود آلفا',
        address: 'خیابان اصلی، پلاک ۱',
        isOpen: true,
        logoUrl: 'https://i.pravatar.cc/150?u=store1',
      ),
      const StoreEntity(
        id: 2,
        name: 'پیتزا بتا',
        address: 'میدان مرکزی',
        isOpen: false,
        logoUrl: 'https://i.pravatar.cc/150?u=store2',
      ),
      const StoreEntity(
        id: 3,
        name: 'کافه گاما',
        address: 'بلوار فرعی، کوچه ۳',
        isOpen: true,
        logoUrl: 'https://i.pravatar.cc/150?u=store3',
      ),
    ];

    // برگرداندن داده‌های ساختگی در حالت موفقیت
    return Right(fakeStores);

    // برای تست حالت خطا می‌توانید خط بالا را کامنت و خط زیر را فعال کنید
    // return Left(ServerFailure());
  }
}
