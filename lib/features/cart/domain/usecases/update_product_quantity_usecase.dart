// lib/features/cart/domain/usecases/update_product_quantity_usecase.dart

import 'package:customer_app/features/cart/domain/entities/cart_entity.dart';
import 'package:customer_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:customer_app/features/product/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/usecase.dart';

class UpdateProductQuantityUsecase implements UseCase<CartEntity, Params> {
  final CartRepository repository;

  UpdateProductQuantityUsecase(this.repository);

  @override
  Future<Either<Failure, CartEntity>> call(Params params) async {
    return await repository.updateProductQuantity(
      params.product,
      params.newQuantity,
    );
  }
}

class Params extends Equatable {
  final ProductEntity product;
  final int newQuantity;

  const Params({required this.product, required this.newQuantity});

  @override
  List<Object> get props => [product, newQuantity];
}
