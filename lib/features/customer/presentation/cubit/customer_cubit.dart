// در مسیر: lib/features/customer/presentation/cubit/customer_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:customer_app/features/customer/domain/usecases/get_customer_details.dart';
import 'package:equatable/equatable.dart';

// این دو import برای اتصال به لایه Domain ضروری هستند

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  // ما به UseCase نیاز داریم تا بتوانیم داده‌ها را درخواست کنیم
  final GetCustomerDetails getCustomerDetails;

  // Constructor را طوری تغییر می‌دهیم که UseCase را به عنوان ورودی بگیرد
  CustomerCubit({required this.getCustomerDetails}) : super(CustomerInitial());

  // این تابع، منطق اصلی دریافت داده و ارسال وضعیت‌های مختلف را مدیریت می‌کند
  Future<void> fetchCustomerDetails(int id) async {
    emit(CustomerLoading()); // ارسال وضعیت "در حال بارگذاری"

    final failureOrCustomer = await getCustomerDetails(Params(id: id));

    failureOrCustomer.fold(
      (failure) {
        // در صورت شکست، وضعیت خطا را ارسال کن
        emit(const CustomerError('خطا در دریافت اطلاعات از سرور'));
      },
      (customer) {
        // در صورت موفقیت، وضعیت موفق و داده‌های دریافتی را ارسال کن
        emit(CustomerLoaded(customer));
      },
    );
  }
}
