// در مسیر: lib/core/di/service_locator.dart

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/customer/data/datasources/customer_remote_datasource.dart';
import '../../features/customer/data/repositories/fake_customer_repository_impl.dart';
import '../../features/customer/domain/repositories/customer_repository.dart';
import '../../features/customer/domain/usecases/get_customer_details.dart';
import '../../features/customer/presentation/cubit/customer_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => CustomerCubit(getCustomerDetails: sl()));
  sl.registerLazySingleton(() => GetCustomerDetails(sl()));
  sl.registerLazySingleton<CustomerRepository>(
    () => FakeCustomerRepositoryImpl(),
  );
  sl.registerLazySingleton<CustomerRemoteDataSource>(
    () => CustomerRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton(
    () => Dio(BaseOptions(baseUrl: 'https://fake-api.com')),
  );
}
