// در مسیر: lib/features/customer/presentation/cubit/customer_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:customer_app/features/customer/domain/entities/customer_entity.dart';
import 'package:customer_app/features/customer/domain/usecases/get_customer_details.dart';
import 'package:equatable/equatable.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final GetCustomerDetails getCustomerDetails;

  CustomerCubit({required this.getCustomerDetails}) : super(CustomerInitial());

  Future<void> fetchCustomerDetails(int id) async {
    emit(CustomerLoading());
    final failureOrCustomer = await getCustomerDetails(Params(id: id));
    failureOrCustomer.fold(
      (failure) => emit(const CustomerError('خطا در دریافت اطلاعات')),
      (customer) => emit(CustomerLoaded(customer)),
    );
  }
}
