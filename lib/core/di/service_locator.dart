// lib/core/di/service_locator.dart

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// --- Imports ---
import '../../features/customer/data/datasources/customer_remote_datasource.dart';
import '../../features/customer/data/repositories/fake_customer_repository_impl.dart';
import '../../features/customer/domain/repositories/customer_repository.dart';
import '../../features/customer/domain/usecases/get_customer_details.dart';
import '../../features/customer/presentation/cubit/customer_cubit.dart';

import '../../features/store/data/datasources/store_remote_datasource.dart';
import '../../features/store/data/repositories/fake_store_repository_impl.dart';
import '../../features/store/domain/repositories/store_repository.dart';
import '../../features/store/domain/usecases/get_stores_usecase.dart';
import '../../features/store/presentation/cubit/store_cubit.dart';

import '../../features/product/data/datasources/product_remote_datasource.dart';
import '../../features/product/data/repositories/fake_product_repository_impl.dart';
import '../../features/product/domain/repositories/product_repository.dart';
import '../../features/product/domain/usecases/get_products_by_store_usecase.dart';
import '../../features/product/presentation/cubit/product_cubit.dart';

import '../../features/cart/data/repositories/fake_cart_repository_impl.dart';
import '../../features/cart/domain/repositories/cart_repository.dart';
import '../../features/cart/domain/usecases/add_product_to_cart_usecase.dart';
import '../../features/cart/domain/usecases/get_cart_usecase.dart';
import '../../features/cart/domain/usecases/remove_product_from_cart_usecase.dart';
import '../../features/cart/domain/usecases/update_product_quantity_usecase.dart';
import '../../features/cart/presentation/bloc/cart_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // --- Features ---
  // BLoCs & Cubits (Factory - یک نمونه جدید برای هر بار درخواست)
  sl.registerFactory(() => CustomerCubit(getCustomerDetails: sl()));
  sl.registerFactory(() => StoreCubit(getStoresUsecase: sl()));
  sl.registerFactory(() => ProductCubit(getProductsByStoreUsecase: sl()));

  // CartBloc (Singleton - فقط یک نمونه در کل برنامه)
  sl.registerLazySingleton(
    () => CartBloc(
      getCart: sl(),
      addProductToCart: sl(),
      removeProductFromCart: sl(),
    ),
  );

  // UseCases (Lazy Singleton - فقط یک بار ساخته می‌شوند)
  sl.registerLazySingleton(() => GetCustomerDetails(sl()));
  sl.registerLazySingleton(() => GetStoresUsecase(sl()));
  sl.registerLazySingleton(() => GetProductsByStoreUsecase(sl()));
  sl.registerLazySingleton(() => GetCartUsecase(sl()));
  sl.registerLazySingleton(() => AddProductToCartUsecase(sl()));
  sl.registerLazySingleton(() => RemoveProductFromCartUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductQuantityUsecase(sl()));

  // Repositories (Lazy Singleton - استفاده از نسخه Fake برای تست)
  sl.registerLazySingleton<CustomerRepository>(
    () => FakeCustomerRepositoryImpl(),
  );
  sl.registerLazySingleton<StoreRepository>(() => FakeStoreRepositoryImpl());
  sl.registerLazySingleton<ProductRepository>(
    () => FakeProductRepositoryImpl(),
  );
  sl.registerLazySingleton<CartRepository>(() => FakeCartRepositoryImpl());

  // DataSources (Lazy Singleton)
  sl.registerLazySingleton<CustomerRemoteDataSource>(
    () => CustomerRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<StoreRemoteDataSource>(
    () => StoreRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dio: sl()),
  );

  // --- External ---
  sl.registerLazySingleton(
    () => Dio(BaseOptions(baseUrl: 'https://fake-api.com')),
  );
}
