// lib/features/cart/presentation/pages/cart_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../bloc/cart_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سبد خرید شما')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CartLoaded) {
            if (state.cart.items.isEmpty) {
              return const Center(child: Text('سبد خرید شما خالی است.'));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cart.items.length,
                    itemBuilder: (context, index) {
                      return _buildCartItem(context, state.cart.items[index]);
                    },
                  ),
                ),
                _buildTotals(context, state.cart),
              ],
            );
          }
          if (state is CartError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItemEntity item) {
    return ListTile(
      leading: Image.network(
        item.product.imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(item.product.name),
      subtitle: Text('${item.product.price.toStringAsFixed(0)} تومان'),
      trailing: Text('x ${item.quantity}'),
    );
  }

  Widget _buildTotals(BuildContext context, cart) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'جمع کل:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${cart.totalPrice.toStringAsFixed(0)} تومان',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  /* به صفحه پرداخت می‌رویم */
                },
                child: const Text('ادامه و پرداخت'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
