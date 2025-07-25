// lib/features/product/presentation/pages/product_list_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/di/service_locator.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../domain/entities/product_entity.dart';
import '../cubit/product_cubit.dart';

class ProductListPage extends StatelessWidget {
  final int storeId;
  final String storeName;

  const ProductListPage({
    super.key,
    required this.storeId,
    required this.storeName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('منوی $storeName')),
      body: BlocProvider(
        create: (_) => sl<ProductCubit>()..fetchProductsByStore(storeId),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return _buildLoadingShimmer();
            } else if (state is ProductLoaded) {
              if (state.products.isEmpty) {
                return const Center(
                  child: Text('محصولی در این فروشگاه یافت نشد.'),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return _buildProductListItem(context, state.products[index]);
                },
              );
            } else if (state is ProductError) {
              return _buildErrorView(context, state.message);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildProductListItem(BuildContext context, ProductEntity product) {
    final textTheme = Theme.of(context).textTheme;
    final hasDiscount = product.discountPrice != null;

    return Opacity(
      opacity: product.isAvailable ? 1.0 : 0.6,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                product.imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (hasDiscount)
                              Text(
                                '${product.price.toStringAsFixed(0)}',
                                style: textTheme.bodySmall?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                              ),
                            Text(
                              '${product.finalPrice.toStringAsFixed(0)} تومان',
                              style: textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        if (product.isAvailable)
                          InkWell(
                            onTap: () {
                              context.read<CartBloc>().add(
                                CartProductAdded(product),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${product.name} به سبد خرید اضافه شد',
                                    ),
                                  ),
                                );
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          )
                        else
                          Text(
                            'ناموجود',
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    /* ... Loading Shimmer Code ... */
    return Container();
  }

  Widget _buildErrorView(BuildContext context, String message) {
    /* ... Error View Code ... */
    return Container();
  }
}
