// lib/features/customer/domain/usecases/get_customer_details.dart

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/customer_entity.dart';
import '../repositories/customer_repository.dart';

// این UseCase وظیفه دریافت اطلاعات مشتری را بر عهده دارد.
class GetCustomerDetails implements UseCase<CustomerEntity, Params> {
  final CustomerRepository repository;

  // ما ریپازیتوری را از طریق Constructor به این کلاس تزریق (Inject) می‌کنیم.
  // این کار به ما اجازه می‌دهد در تست‌ها از یک ریپازیتوری ساختگی (Mock) استفاده کنیم.
  GetCustomerDetails(this.repository);

  // متد call باعث می‌شود که بتوانیم از این کلاس مانند یک تابع استفاده کنیم.
  @override
  Future<Either<Failure, CustomerEntity>> call(Params params) async {
    // این UseCase هیچ منطق اضافه‌ای ندارد و فقط متد مربوطه را از ریپازیتوری فراخوانی می‌کند.
    return await repository.getCustomerDetails(params.id);
  }
}

// برای ارسال پارامترها به UseCase به شکلی ساختاریافته، از این کلاس استفاده می‌کنیم.
class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}
