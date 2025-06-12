// lib/features/cart/data/repositories/cart_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_datasource.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CartEntity>> getCart() async {
    try {
      final remoteCart = await remoteDataSource.getCart();
      return Right(remoteCart);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CartEntity>> addProductToCart(
    ProductEntity product,
  ) async {
    try {
      final remoteCart = await remoteDataSource.addProductToCart(product.id);
      return Right(remoteCart);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // پیاده‌سازی remove و update نیز به همین شکل خواهد بود
  @override
  Future<Either<Failure, CartEntity>> removeProductFromCart(
    ProductEntity product,
  ) async {
    // ...
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CartEntity>> updateProductQuantity(
    ProductEntity product,
    int newQuantity,
  ) async {
    // ...
    throw UnimplementedError();
  }
}
