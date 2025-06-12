// lib/features/customer/data/repositories/customer_repository_impl.dart

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/repositories/customer_repository.dart';
import '../datasources/customer_remote_datasource.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource remoteDataSource;
  // در آینده یک کلاس برای بررسی وضعیت اینترنت هم به اینجا اضافه خواهیم کرد
  // final NetworkInfo networkInfo;

  CustomerRepositoryImpl({
    required this.remoteDataSource,
    // required this.networkInfo,
  });

  @override
  Future<Either<Failure, CustomerEntity>> getCustomerDetails(int id) async {
    // اینجا می‌توانیم ابتدا وضعیت اتصال به اینترنت را چک کنیم
    // if (await networkInfo.isConnected) {
    try {
      final remoteCustomer = await remoteDataSource.getCustomerDetails(id);
      // DataSource یک CustomerModel را برمی‌گرداند که از CustomerEntity ارث‌بری کرده،
      // بنابراین می‌توانیم آن را مستقیماً به عنوان خروجی موفق (Right) برگردانیم.
      return Right(remoteCustomer);
    } on ServerException {
      // اگر DataSource خطای سرور را پرتاب کند، ما آن را به یک ServerFailure تبدیل می‌کنیم.
      return Left(ServerFailure());
    }
    // } else {
    //   return Left(NetworkFailure()); // یک نوع Failure جدید برای خطای اینترنت
    // }
  }
}
