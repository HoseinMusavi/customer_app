// lib/features/cart/data/repositories/fake_cart_repository_impl.dart

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repositories/cart_repository.dart';

// این نسخه ساختگی، تمام منطق سبد خرید را به صورت محلی در حافظه مدیریت می‌کند.
class FakeCartRepositoryImpl implements CartRepository {
  final List<CartItemEntity> _items = [];

  @override
  Future<Either<Failure, CartEntity>> addProductToCart(
    ProductEntity product,
  ) async {
    try {
      final index = _items.indexWhere((item) => item.product.id == product.id);
      if (index != -1) {
        final existingItem = _items[index];
        _items[index] = CartItemEntity(
          product: existingItem.product,
          quantity: existingItem.quantity + 1,
        );
      } else {
        _items.add(CartItemEntity(product: product, quantity: 1));
      }
      return Right(CartEntity(items: List.from(_items)));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CartEntity>> getCart() async {
    return Right(CartEntity(items: List.from(_items)));
  }

  @override
  Future<Either<Failure, CartEntity>> removeProductFromCart(
    ProductEntity product,
  ) async {
    try {
      _items.removeWhere((item) => item.product.id == product.id);
      return Right(CartEntity(items: List.from(_items)));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CartEntity>> updateProductQuantity(
    ProductEntity product,
    int newQuantity,
  ) async {
    try {
      if (newQuantity <= 0) {
        _items.removeWhere((item) => item.product.id == product.id);
      } else {
        final index = _items.indexWhere(
          (item) => item.product.id == product.id,
        );
        if (index != -1) {
          _items[index] = CartItemEntity(
            product: product,
            quantity: newQuantity,
          );
        }
      }
      return Right(CartEntity(items: List.from(_items)));
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
