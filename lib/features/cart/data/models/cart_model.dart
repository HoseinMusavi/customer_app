// lib/features/cart/data/models/cart_model.dart
import '../../domain/entities/cart_entity.dart';
import 'cart_item_model.dart';

class CartModel extends CartEntity {
  const CartModel({required super.items});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      items: (json['items'] as List)
          .map((itemJson) => CartItemModel.fromJson(itemJson))
          .toList(),
    );
  }
}
