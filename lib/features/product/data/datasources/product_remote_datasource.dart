// lib/features/product/data/datasources/product_remote_datasource.dart

import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  /// این متد باید به endpoint مربوط به دریافت لیست محصولات یک فروشگاه خاص وصل شود.
  Future<List<ProductModel>> getProductsByStore(int storeId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> getProductsByStore(int storeId) async {
    // بر اساس پروپوزال، این endpoint لیست محصولات یک فروشگاه را برمی‌گرداند
    final response = await dio.get('/api/store/$storeId/products/');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }
}
