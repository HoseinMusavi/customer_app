// lib/features/customer/presentation/cubit/customer_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:customer_app/features/customer/domain/entities/customer_entity.dart';
import 'package:customer_app/features/customer/domain/usecases/get_customer_details.dart';
import 'package:equatable/equatable.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final GetCustomerDetails getCustomerDetails;

  CustomerCubit({required this.getCustomerDetails}) : super(CustomerInitial());

  Future<void> fetchCustomerDetails(int id) async {
    // 1. ابتدا وضعیت "در حال بارگذاری" را به UI اطلاع بده
    emit(CustomerLoading());

    // 2. فراخوانی UseCase برای دریافت داده
    final failureOrCustomer = await getCustomerDetails(Params(id: id));

    // 3. مدیریت نتیجه بازگشتی از UseCase
    failureOrCustomer.fold(
      // 3.1. در صورت شکست (Failure)
      (failure) {
        emit(const CustomerError('خطا در دریافت اطلاعات از سرور'));
      },
      // 3.2. در صورت موفقیت (Success)
      (customer) {
        emit(CustomerLoaded(customer));
      },
    );
  }
}
