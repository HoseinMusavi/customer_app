// lib/features/store/data/datasources/store_remote_datasource.dart

import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../models/store_model.dart';

abstract class StoreRemoteDataSource {
  /// این متد باید به endpoint مربوط به دریافت لیست فروشگاه‌ها در API شما وصل شود.
  /// در صورت بروز هرگونه خطا، باید یک [ServerException] پرتاب کند.
  Future<List<StoreModel>> getStores();
}

class StoreRemoteDataSourceImpl implements StoreRemoteDataSource {
  final Dio dio;

  StoreRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<StoreModel>> getStores() async {
    // بر اساس پروپوزال، این endpoint لیست فروشگاه‌ها را برمی‌گرداند
    final response = await dio.get('/api/stores/');

    if (response.statusCode == 200) {
      // پاسخ API یک لیست از جیسان‌ها است.
      // ما باید روی این لیست گردش کرده و هر جیسان را به یک StoreModel تبدیل کنیم.
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => StoreModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }
}
