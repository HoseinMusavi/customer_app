// lib/features/cart/presentation/bloc/cart_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/usecases/add_product_to_cart_usecase.dart';
import '../../domain/usecases/get_cart_usecase.dart';
import '../../domain/usecases/remove_product_from_cart_usecase.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUsecase getCart;
  final AddProductToCartUsecase addProductToCart;
  final RemoveProductFromCartUsecase removeProductFromCart;

  CartBloc({
    required this.getCart,
    required this.addProductToCart,
    required this.removeProductFromCart,
  }) : super(CartLoading()) {
    // تعریف می‌کنیم که برای هر رویداد، چه تابعی باید اجرا شود
    on<CartStarted>(_onCartStarted);
    on<CartProductAdded>(_onCartProductAdded);
    on<CartProductRemoved>(_onCartProductRemoved);
  }

  // تابع برای رویداد CartStarted
  void _onCartStarted(CartStarted event, Emitter<CartState> emit) async {
    final failureOrCart = await getCart(NoParams());
    failureOrCart.fold(
      (failure) => emit(const CartError('خطا در بارگذاری سبد خرید')),
      (cart) => emit(CartLoaded(cart)),
    );
  }

  // تابع برای رویداد CartProductAdded
  void _onCartProductAdded(
    CartProductAdded event,
    Emitter<CartState> emit,
  ) async {
    final failureOrCart = await addProductToCart(
      Params(product: event.product),
    );
    failureOrCart.fold(
      (failure) => emit(const CartError('خطا در افزودن محصول')),
      (cart) => emit(CartLoaded(cart)),
    );
  }

  // تابع برای رویداد CartProductRemoved
  void _onCartProductRemoved(
    CartProductRemoved event,
    Emitter<CartState> emit,
  ) async {
    final failureOrCart = await removeProductFromCart(
      RemoveProductFromCartUsecaseParams(product: event.product),
    );
    failureOrCart.fold(
      (failure) => emit(const CartError('خطا در حذف محصول')),
      (cart) => emit(CartLoaded(cart)),
    );
  }
}

// ما برای usecase های add و remove کلاس Params جداگانه ساختیم،
// اما می‌توانیم برای سادگی، از یک کلاس Params عمومی‌تر استفاده کنیم یا حتی مستقیم ProductEntity را پاس دهیم.
// برای حفظ ساختار، فعلا از همین روش استفاده می‌کنیم.
// نکته: نام کلاس پارامتر در فایل remove_product_from_cart_usecase.dart را به RemoveProductFromCartUsecaseParams تغییر دهید تا با add تداخل نداشته باشد.
