import 'dart:io';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:customer_app/core/usecase/usecase.dart';
import 'package:customer_app/features/customer/domain/entities/customer_entity.dart';
import 'package:customer_app/features/customer/domain/usecases/get_customer_details.dart';
import 'package:customer_app/features/customer/domain/usecases/update_customer_profile.dart';
import 'package:equatable/equatable.dart';
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
    // ... (این متد بدون تغییر باقی می‌ماند)
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
      debugPrint("❌ [Cubit] -> saveProfile: خطا! کاربر احراز هویت نشده است.");
      emit(const CustomerError('کاربر احراز هویت نشده است'));
      return;
    }

    final currentState = state;
    String? currentAvatarUrl;
    if (currentState is CustomerLoaded) {
      currentAvatarUrl = currentState.customer.avatarUrl;
    }

    final customerData = CustomerEntity(
      id: user.id,
      fullName: fullName,
      email: user.email ?? '',
      phone: phone,
      avatarUrl: currentAvatarUrl,
    );

    debugPrint(
      " passo [Cubit] -> saveProfile: اطلاعات برای ارسال به UseCase آماده شد: ${customerData.fullName}",
    );

    final params = UpdateCustomerParams(
      customer: customerData,
      imageFile: imageFile,
    );
    final failureOrSuccess = await updateCustomerProfileUseCase(params);

    failureOrSuccess.fold(
      (failure) {
        debugPrint(
          "❌ [Cubit] -> saveProfile: عملیات ناموفق بود. خطا: $failure",
        );
        emit(CustomerError('خطا در ذخیره اطلاعات: ${failure.toString()}'));
      },
      (updatedCustomer) {
        debugPrint(
          "✅ [Cubit] -> saveProfile: پروفایل با موفقیت ذخیره شد. به‌روزرسانی state به CustomerLoaded.",
        );
        emit(CustomerLoaded(updatedCustomer));
      },
    );
  }
}
