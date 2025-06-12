// در مسیر: lib/core/di/service_locator.dart

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// وارد کردن فایل‌های لایه Data
import '../../features/customer/data/datasources/customer_remote_datasource.dart';
import '../../features/customer/data/repositories/customer_repository_impl.dart';
import '../../features/customer/data/repositories/fake_customer_repository_impl.dart'; // ریپازیتوری ساختگی برای تست

// وارد کردن فایل‌های لایه Domain
import '../../features/customer/domain/repositories/customer_repository.dart';
import '../../features/customer/domain/usecases/get_customer_details.dart';

// وارد کردن فایل‌های لایه Presentation
import '../../features/customer/presentation/cubit/customer_cubit.dart';

// یک نمونه سراسری از GetIt به عنوان Service Locator
final sl = GetIt.instance;

Future<void> init() async {
  // در اینجا تمام وابستگی‌های برنامه را ثبت (Register) می‌کنیم.

  // ----------------- Features - Customer -----------------

  // Cubit
  // sl.registerFactory(() => CustomerCubit(getCustomerDetails: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetCustomerDetails(sl()));

  // Repository (استفاده از نسخه ساختگی برای تست بدون بک‌اند)
  sl.registerLazySingleton<CustomerRepository>(
    () => FakeCustomerRepositoryImpl(),
  );
  /*
  // این نسخه واقعی است که بعداً از آن استفاده خواهیم کرد
  sl.registerLazySingleton<CustomerRepository>(
    () => CustomerRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );
  */

  // Data sources
  sl.registerLazySingleton<CustomerRemoteDataSource>(
    () => CustomerRemoteDataSourceImpl(dio: sl()),
  );

  // ----------------- External Dependencies -----------------
  sl.registerLazySingleton(() {
    // لطفاً آدرس پایه API خود را در آینده اینجا قرار دهید
    final dio = Dio(
      BaseOptions(
        baseUrl:
            'https://fake-api.com', // این آدرس فعلا مهم نیست چون از ریپازیتوری ساختگی استفاده می‌کنیم
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
    return dio;
  });
}
