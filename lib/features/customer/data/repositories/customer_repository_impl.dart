import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
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
      debugPrint(
        "✅ [Repository] -> getCustomerDetails: در حال فراخوانی DataSource...",
      );
      final customerModel = await remoteDataSource.getCustomerDetails();
      final addresses = await remoteDataSource.getAddresses();

      final customerEntity = CustomerEntity(
        id: customerModel.id,
        fullName: customerModel.fullName,
        email: customerModel.email,
        phone: customerModel.phone,
        avatarUrl: customerModel.avatarUrl,
        defaultAddressId: customerModel.defaultAddressId,
        addresses: addresses,
      );

      debugPrint(
        "✅ [Repository] -> getCustomerDetails: داده از DataSource دریافت و به Entity تبدیل شد.",
      );
      return Right(customerEntity);
    } on ServerException catch (e) {
      debugPrint(
        "❌ [Repository] -> getCustomerDetails: خطای سرور دریافت شد: ${e.message}",
      );
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
          " passo [Repository] -> updateCustomerProfile: در حال آپلود عکس جدید...",
        );
        avatarUrl = await remoteDataSource.uploadAvatar(imageFile);
        debugPrint(
          "✅ [Repository] -> updateCustomerProfile: آپلود عکس موفق بود.",
        );
      }

      final customerToUpdate = CustomerModel(
        id: customer.id,
        fullName: customer.fullName,
        email: customer.email,
        phone: customer.phone,
        avatarUrl: avatarUrl,
        defaultAddressId: customer.defaultAddressId,
      );

      debugPrint(
        " passo [Repository] -> updateCustomerProfile: در حال ارسال اطلاعات به DataSource...",
      );
      final updatedCustomer = await remoteDataSource.updateCustomerProfile(
        customerToUpdate,
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
    }
  }
}
