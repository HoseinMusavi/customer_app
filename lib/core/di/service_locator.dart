// lib/core/di/service_locator.dart

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/cart/data/repositories/fake_cart_repository_impl.dart';
import '../../features/cart/domain/repositories/cart_repository.dart';
import '../../features/cart/domain/usecases/add_product_to_cart_usecase.dart';
import '../../features/cart/domain/usecases/get_cart_usecase.dart';
import '../../features/cart/domain/usecases/remove_product_from_cart_usecase.dart';
import '../../features/cart/domain/usecases/update_product_quantity_usecase.dart';
import '../../features/cart/presentation/bloc/cart_bloc.dart';
import '../../features/customer/data/repositories/fake_customer_repository_impl.dart';
import '../../features/customer/domain/repositories/customer_repository.dart';
import '../../features/customer/domain/usecases/get_customer_details.dart';
import '../../features/customer/presentation/cubit/customer_cubit.dart';
import '../../features/product/data/repositories/fake_product_repository_impl.dart';
import '../../features/product/domain/repositories/product_repository.dart';
import '../../features/product/domain/usecases/get_products_by_store_usecase.dart';
import '../../features/product/presentation/cubit/product_cubit.dart';
import '../../features/promotion/data/repositories/fake_promotion_repository_impl.dart';
import '../../features/promotion/domain/repositories/promotion_repository.dart';
import '../../features/promotion/domain/usecases/get_promotions_usecase.dart';
import '../../features/store/data/repositories/fake_store_repository_impl.dart';
import '../../features/store/domain/repositories/store_repository.dart';
import '../../features/store/domain/usecases/get_stores_usecase.dart';
import '../../features/store/presentation/cubit/dashboard_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoCs & Cubits
  sl.registerFactory(() => CustomerCubit(getCustomerDetails: sl()));
  sl.registerFactory(() => ProductCubit(getProductsByStoreUsecase: sl()));
  sl.registerFactory(
    () => DashboardCubit(getStoresUsecase: sl(), getPromotionsUsecase: sl()),
  ); // <-- Cubit جدید

  sl.registerLazySingleton(
    () => CartBloc(
      getCart: sl(),
      addProductToCart: sl(),
      removeProductFromCart: sl(),
      updateProductQuantity: sl(),
    ),
  );

  // UseCases
  sl.registerLazySingleton(() => GetCustomerDetails(sl()));
  sl.registerLazySingleton(() => GetStoresUsecase(sl()));
  sl.registerLazySingleton(() => GetProductsByStoreUsecase(sl()));
  sl.registerLazySingleton(
    () => GetPromotionsUsecase(sl()),
  ); // <-- UseCase جدید
  sl.registerLazySingleton(() => GetCartUsecase(sl()));
  sl.registerLazySingleton(() => AddProductToCartUsecase(sl()));
  sl.registerLazySingleton(() => RemoveProductFromCartUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductQuantityUsecase(sl()));

  // Repositories
  sl.registerLazySingleton<CustomerRepository>(
    () => FakeCustomerRepositoryImpl(),
  );
  sl.registerLazySingleton<StoreRepository>(() => FakeStoreRepositoryImpl());
  sl.registerLazySingleton<ProductRepository>(
    () => FakeProductRepositoryImpl(),
  );
  sl.registerLazySingleton<CartRepository>(() => FakeCartRepositoryImpl());
  sl.registerLazySingleton<PromotionRepository>(
    () => FakePromotionRepositoryImpl(),
  ); // <-- Repository جدید

  // External
  sl.registerLazySingleton(
    () => Dio(BaseOptions(baseUrl: 'https://fake-api.com')),
  );
}
