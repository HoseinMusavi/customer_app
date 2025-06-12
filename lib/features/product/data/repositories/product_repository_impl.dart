// lib/features/product/data/repositories/product_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByStore(
    int storeId,
  ) async {
    try {
      final remoteProducts = await remoteDataSource.getProductsByStore(storeId);
      return Right(remoteProducts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
