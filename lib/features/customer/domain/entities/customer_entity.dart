import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  final int id;
  final String fullName;
  final String email;
  final String phone;
  final String? avatarUrl; // آدرس عکس پروفایل که می‌تواند وجود نداشته باشد

  const CustomerEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    this.avatarUrl,
  });

  // این متد از پکیج equatable می‌آید و برای مقایسه دو آبجکت از این کلاس استفاده می‌شود.
  // به این ترتیب، اگر دو مشتری تمام این ویژگی‌ها را یکسان داشته باشند، برابر در نظر گرفته می‌شوند.
  // این کار در مدیریت وضعیت (State Management) بسیار مهم است تا از بازрисов‌های غیرضروری UI جلوگیری شود.
  @override
  List<Object?> get props => [id, fullName, email, phone, avatarUrl];
}
