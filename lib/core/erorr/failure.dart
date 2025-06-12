// lib/core/error/failure.dart

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

// انواع خطاهای عمومی که در کل برنامه ممکن است رخ دهند
class ServerFailure extends Failure {} // خطای مربوط به سرور و API

class CacheFailure extends Failure {}  // خطای مربوط به دیتابیس محلی یا کش