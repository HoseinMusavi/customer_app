import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:customer_app/core/usecase/usecase.dart';
import 'package:customer_app/features/customer/domain/entities/customer_entity.dart';
import 'package:customer_app/features/customer/domain/usecases/get_customer_details.dart';
import 'package:customer_app/features/customer/domain/usecases/update_customer_profile.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final GetCustomerDetails getCustomerDetailsUseCase;
  final UpdateCustomerProfile updateCustomerProfileUseCase;

  CustomerCubit({
    required this.getCustomerDetailsUseCase,
    required this.updateCustomerProfileUseCase,
  }) : super(CustomerInitial());

  Future<void> fetchCustomerDetails() async {
    debugPrint(
      "✅ [Cubit] -> fetchCustomerDetails: شروع دریافت اطلاعات پروفایل.",
    );
    emit(CustomerLoading());
    final failureOrCustomer = await getCustomerDetailsUseCase(NoParams());

    failureOrCustomer.fold(
      (failure) {
        debugPrint(
          "❌ [Cubit] -> fetchCustomerDetails: دریافت اطلاعات ناموفق بود. خطا: ${failure.toString()}",
        );
        emit(CustomerError(failure.toString()));
      },
      (customer) {
        debugPrint(
          "✅ [Cubit] -> fetchCustomerDetails: اطلاعات با موفقیت دریافت شد. نمایش پروفایل.",
        );
        emit(CustomerLoaded(customer));
      },
    );
  }

  Future<void> saveProfile({
    required String fullName,
    required String phone,
    File? imageFile,
  }) async {
    debugPrint("✅ [Cubit] -> saveProfile: شروع عملیات ذخیره پروفایل.");
    emit(CustomerUpdating());

    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      emit(const CustomerError('User not authenticated'));
      return;
    }

    // اگر در حالت خطا (ساخت پروفایل جدید) هستیم، اطلاعات قبلی وجود ندارد
    // در غیر این صورت (ویرایش)، اطلاعات قبلی را نگه می‌داریم
    String? currentAvatarUrl;
    int? currentDefaultAddressId;
    final currentState = state;
    if (currentState is CustomerLoaded) {
      currentAvatarUrl = currentState.customer.avatarUrl;
      currentDefaultAddressId = currentState.customer.defaultAddressId;
    }

    final customerData = CustomerEntity(
      id: user.id,
      fullName: fullName,
      email: user.email ?? '',
      phone: phone,
      avatarUrl: currentAvatarUrl,
      defaultAddressId: currentDefaultAddressId,
    );

    final params = UpdateCustomerParams(
      customer: customerData,
      imageFile: imageFile,
    );
    final failureOrSuccess = await updateCustomerProfileUseCase(params);

    failureOrSuccess.fold(
      (failure) {
        debugPrint(
          "❌ [Cubit] -> saveProfile: ذخیره ناموفق. خطا: ${failure.toString()}",
        );
        emit(CustomerError(failure.toString()));
      },
      (updatedCustomer) {
        debugPrint("✅ [Cubit] -> saveProfile: ذخیره موفق. نمایش پروفایل جدید.");
        emit(CustomerLoaded(updatedCustomer));
      },
    );
  }
}
