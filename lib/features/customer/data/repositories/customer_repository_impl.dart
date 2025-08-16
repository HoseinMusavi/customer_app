import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/repositories/customer_repository.dart';
import '../datasources/customer_remote_datasource.dart';
import '../models/customer_model.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource remoteDataSource;
  CustomerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CustomerEntity>> getCustomerDetails() async {
    try {
      final customerModel = await remoteDataSource.getCustomerDetails();
      // Note: Address fetching logic is temporarily removed for simplicity.
      // We will add it back when building the address management feature.
      return Right(customerModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CustomerEntity>> updateCustomerProfile(
    CustomerEntity customer,
    File? imageFile,
  ) async {
    try {
      debugPrint(
        "✅ [Repository] -> updateCustomerProfile: شروع عملیات در ریپازیتوری.",
      );
      String? avatarUrl = customer.avatarUrl;

      if (imageFile != null) {
        debugPrint(
          " passo [Repository] -> updateCustomerProfile: عکس جدید شناسایی شد. شروع آپلود...",
        );
        avatarUrl = await remoteDataSource.uploadAvatar(imageFile);
        debugPrint(
          "✅ [Repository] -> updateCustomerProfile: آپلود عکس موفقیت‌آمیز بود. URL: $avatarUrl",
        );
      } else {
        debugPrint(
          " passo [Repository] -> updateCustomerProfile: عکس جدیدی برای آپلود وجود ندارد.",
        );
      }

      final customerModel = CustomerModel(
        id: customer.id,
        fullName: customer.fullName,
        email: customer.email,
        phone: customer.phone,
        avatarUrl: avatarUrl,
        defaultAddressId: customer.defaultAddressId,
      );

      debugPrint(
        " passo [Repository] -> updateCustomerProfile: در حال ارسال اطلاعات به DataSource برای ذخیره...",
      );
      final updatedCustomer = await remoteDataSource.updateCustomerProfile(
        customerModel,
      );
      debugPrint(
        "✅ [Repository] -> updateCustomerProfile: اطلاعات با موفقیت در دیتابیس ذخیره شد.",
      );

      return Right(updatedCustomer);
    } on ServerException catch (e) {
      debugPrint(
        "❌ [Repository] -> updateCustomerProfile: خطای سرور دریافت شد: ${e.message}",
      );
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      debugPrint(
        "❌ [Repository] -> updateCustomerProfile: خطای پیش‌بینی نشده: ${e.toString()}",
      );
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
