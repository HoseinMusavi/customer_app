// lib/features/product/presentation/pages/product_list_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart'; // <--- مطمئن شوید این import وجود دارد

import '../../../../core/di/service_locator.dart';
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
      appBar: AppBar(title: Text('منوی ${storeName}')),
      body: BlocProvider(
        create: (_) => sl<ProductCubit>()..fetchProductsByStore(storeId),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return _buildLoadingShimmer(); // حالت لودینگ جدید
            } else if (state is ProductLoaded) {
              if (state.products.isEmpty) {
                return const Center(
                  child: Text('محصولی در این فروشگاه یافت نشد.'),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return _buildProductListItem(context, state.products[index]);
                },
              );
            } else if (state is ProductError) {
              return _buildErrorView(context, state.message); // حالت خطای جدید
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  // ۱. ویجت جدید برای افکت Shimmer
  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 90, height: 90, color: Colors.white),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 16,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          height: 12,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 4),
                        Container(width: 150, height: 12, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ۲. ویجت بهبودیافته برای نمایش هر محصول
  Widget _buildProductListItem(BuildContext context, ProductEntity product) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                product.imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 90,
                  height: 90,
                  color: Colors.grey[200],
                  child: const Icon(Icons.fastfood, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 90, // هم‌اندازه کردن ارتفاع با عکس
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
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
                          style: textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product.price.toStringAsFixed(0)} تومان',
                          style: textTheme.titleSmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            /* منطق افزودن به سبد خرید */
                          },
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: colorScheme.primary,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
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

  // ۳. ویجت جدید برای نمایش خطا
  Widget _buildErrorView(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off, color: Colors.grey[400], size: 60),
          const SizedBox(height: 20),
          Text(message, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () =>
                context.read<ProductCubit>().fetchProductsByStore(storeId),
            child: const Text('تلاش مجدد'),
          ),
        ],
      ),
    );
  }
}
