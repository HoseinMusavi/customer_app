// TODO Implement this library.
// lib/features/customer/data/repositories/fake_customer_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/repositories/customer_repository.dart';

// این کلاس، قرارداد ریپازیتوری را پیاده‌سازی می‌کند اما با داده‌های ساختگی
class FakeCustomerRepositoryImpl implements CustomerRepository {
  @override
  Future<Either<Failure, CustomerEntity>> getCustomerDetails(int id) async {
    print('Fetching data from FAKE repository...');
    // شبیه‌سازی یک تاخیر شبکه
    await Future.delayed(const Duration(seconds: 1));

    // برای تست حالت موفقیت‌آمیز، این بخش را فعال نگه دارید
    const fakeCustomer = CustomerEntity(
      id: 1,
      fullName: "کاربر تستی (آفلاین)",
      email: "test@offline.com",
      phone: "09120000000",
      avatarUrl:
          "https://i.pravatar.cc/150?u=a042581f4e29026704d", // یک عکس پروفایل رندوم
    );
    return const Right(fakeCustomer);

    // -----------------------------------------------------------------

    // برای تست حالت خطا، بخش بالا را کامنت کرده و خط زیر را از کامنت خارج کنید
    // return Left(ServerFailure());
  }
}
