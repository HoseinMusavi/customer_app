// lib/features/store/data/repositories/fake_store_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/store_entity.dart';
import '../../domain/repositories/store_repository.dart';

class FakeStoreRepositoryImpl implements StoreRepository {
  @override
  Future<Either<Failure, List<StoreEntity>>> getStores() async {
    // شبیه‌سازی تاخیر شبکه
    await Future.delayed(const Duration(seconds: 2));

    // ایجاد یک لیست ساختگی از فروشگاه‌ها
    final List<StoreEntity> fakeStores = [
      const StoreEntity(
        id: 1,
        name: 'فست فود آلفا',
        address: 'خیابان اصلی، پلاک ۱',
        isOpen: true,
        logoUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2rQ9Ryl-ju-wxVjyNg458bnF4cUPkEOUrb5m46K5P5hSWDS7rWV68CRHJ8uKxQO6MB2M&usqp=CAU',
      ),
      const StoreEntity(
        id: 2,
        name: 'پیتزا بتا',
        address: 'میدان مرکزی',
        isOpen: false,
        logoUrl:
            'https://besazobechin.com/Files/Uploads/1399-12-6/1399-12-6-ad02b9e3-f5bb-490f-8543-2191cc706d50.webp',
      ),
      const StoreEntity(
        id: 3,
        name: 'کافه گاما',
        address: 'بلوار فرعی، کوچه ۳',
        isOpen: true,
        logoUrl:
            'https://besazobechin.com/Files/Uploads/1399-12-6/1399-12-6-ad02b9e3-f5bb-490f-8543-2191cc706d50.webp',
      ),
      const StoreEntity(
        id: 4,
        name: 'رستوران دلتا',
        address: 'خیابان انقلاب، پلاک ۴۵',
        isOpen: true,
        logoUrl:
            'https://besazobechin.com/Files/Uploads/1399-12-6/1399-12-6-ad02b9e3-f5bb-490f-8543-2191cc706d50.webp',
      ),
      const StoreEntity(
        id: 5,
        name: 'ساندویچی اپسیلون',
        address: 'خیابان آزادی، پلاک ۲۲',
        isOpen: false,
        logoUrl:
            'https://besazobechin.com/Files/Uploads/1399-12-6/1399-12-6-ad02b9e3-f5bb-490f-8543-2191cc706d50.webp',
      ),
      const StoreEntity(
        id: 6,
        name: 'کافی‌شاپ زتا',
        address: 'خیابان ولیعصر، کوچه ۱۰',
        isOpen: true,
        logoUrl:
            'https://besazobechin.com/Files/Uploads/1399-12-6/1399-12-6-ad02b9e3-f5bb-490f-8543-2191cc706d50.webp',
      ),
      const StoreEntity(
        id: 7,
        name: 'رستوران اتا',
        address: 'میدان ونک، پلاک ۷',
        isOpen: false,
        logoUrl:
            'https://besazobechin.com/Files/Uploads/1399-12-6/1399-12-6-ad02b9e3-f5bb-490f-8543-2191cc706d50.webp',
      ),
      const StoreEntity(
        id: 8,
        name: 'فست فود تتا',
        address: 'خیابان شریعتی، پلاک ۸۸',
        isOpen: true,
        logoUrl:
            'https://besazobechin.com/Files/Uploads/1399-12-6/1399-12-6-ad02b9e3-f5bb-490f-8543-2191cc706d50.webp',
      ),
      const StoreEntity(
        id: 9,
        name: 'کافه یوتا',
        address: 'خیابان مطهری، پلاک ۹۹',
        isOpen: true,
        logoUrl:
            'https://besazobechin.com/Files/Uploads/1399-12-6/1399-12-6-ad02b9e3-f5bb-490f-8543-2191cc706d50.webp',
      ),
      const StoreEntity(
        id: 10,
        name: 'رستوران کاف',
        address: 'خیابان فردوسی، پلاک ۱۲۰',
        isOpen: false,
        logoUrl:
            'https://besazobechin.com/Files/Uploads/1399-12-6/1399-12-6-ad02b9e3-f5bb-490f-8543-2191cc706d50.webp',
      ),
    ];

    // برگرداندن داده‌های ساختگی در حالت موفقیت
    return Right(fakeStores);

    // برای تست حالت خطا می‌توانید خط بالا را کامنت و خط زیر را فعال کنید
    // return Left(ServerFailure());
  }
}
