// lib/features/cart/data/datasources/cart_remote_datasource.dart
import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCart();
  Future<CartModel> addProductToCart(int productId);
  Future<CartModel> removeProductFromCart(int productId);
  Future<CartModel> updateProductQuantity(int productId, int quantity);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final Dio dio;
  CartRemoteDataSourceImpl({required this.dio});

  @override
  Future<CartModel> getCart() async {
    final response = await dio.get('/api/cart/');
    if (response.statusCode == 200) {
      return CartModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CartModel> addProductToCart(int productId) async {
    final response = await dio.post(
      '/api/cart/items/',
      data: {'product_id': productId, 'quantity': 1},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return CartModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  // پیاده‌سازی remove و update نیز به همین شکل با متدهای DELETE و PUT/PATCH خواهد بود...
  // فعلا برای سادگی، آنها را کامل نمی‌کنیم.
  @override
  Future<CartModel> removeProductFromCart(int productId) async {
    // dio.delete('/api/cart/items/$productId/');
    throw UnimplementedError();
  }

  @override
  Future<CartModel> updateProductQuantity(int productId, int quantity) async {
    // dio.patch('/api/cart/items/$productId/', data: {'quantity': quantity});
    throw UnimplementedError();
  }
}
