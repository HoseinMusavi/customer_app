// lib/features/store/data/repositories/store_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/store_entity.dart';
import '../../domain/repositories/store_repository.dart';
import '../datasources/store_remote_datasource.dart';

class StoreRepositoryImpl implements StoreRepository {
  final StoreRemoteDataSource remoteDataSource;

  StoreRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<StoreEntity>>> getStores() async {
    try {
      final remoteStores = await remoteDataSource.getStores();
      // DataSource یک List<StoreModel> را برمی‌گرداند که با List<StoreEntity> سازگار است.
      return Right(remoteStores);
    } on ServerException {
      // اگر DataSource خطای سرور پرتاب کند، ما آن را به یک ServerFailure تبدیل می‌کنیم.
      return Left(ServerFailure());
    }
  }
}
