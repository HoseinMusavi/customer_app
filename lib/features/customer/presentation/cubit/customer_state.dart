// lib/features/customer/presentation/cubit/customer_state.dart

part of 'customer_cubit.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

// وضعیت اولیه، قبل از هر اقدامی
class CustomerInitial extends CustomerState {}

// وضعیت در حال بارگذاری داده‌ها
class CustomerLoading extends CustomerState {}

// وضعیت موفقیت‌آمیز، زمانی که داده‌ها دریافت شده‌اند
class CustomerLoaded extends CustomerState {
  final CustomerEntity customer;

  const CustomerLoaded(this.customer);

  @override
  List<Object> get props => [customer];
}

// وضعیت خطا، زمانی که مشکلی در دریافت داده رخ داده است
class CustomerError extends CustomerState {
  final String message;

  const CustomerError(this.message);

  @override
  List<Object> get props => [message];
}
