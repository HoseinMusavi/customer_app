// lib/features/store/presentation/pages/store_list_page.dart

import 'package:customer_app/features/cart/presentation/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/di/service_locator.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../product/presentation/pages/product_list_page.dart';
import '../../domain/entities/store_entity.dart';
import '../cubit/store_cubit.dart';

class StoreListPage extends StatelessWidget {
  const StoreListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فروشگاه‌ها'),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: Badge(
                  // ... (بقیه کد Badge)
                  child: IconButton(
                    onPressed: () {
                      // +++ تغییر اصلی اینجاست +++
                      // با کلیک، به صفحه سبد خرید منتقل می‌شویم
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) => sl<StoreCubit>()..fetchStores(),
        child: BlocBuilder<StoreCubit, StoreState>(
          builder: (context, state) {
            if (state is StoreLoading) {
              return _buildLoadingShimmer();
            } else if (state is StoreLoaded) {
              return _buildStoreGrid(context, state.stores);
            } else if (state is StoreError) {
              return _buildErrorView(context, state.message);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  // ویجت برای افکت Shimmer در حالت لودینگ
  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        padding: const EdgeInsets.all(12.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 0.8,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }

  // ویجت برای نمایش گرید فروشگاه‌ها
  Widget _buildStoreGrid(BuildContext context, List<StoreEntity> stores) {
    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 0.8,
      ),
      itemCount: stores.length,
      itemBuilder: (context, index) {
        return _buildStoreCard(context, stores[index]);
      },
    );
  }

  // ویجت برای نمایش کارت هر فروشگاه
  Widget _buildStoreCard(BuildContext context, StoreEntity store) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                ProductListPage(storeId: store.id, storeName: store.name),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                color: Colors.grey[200],
                child: store.logoUrl != null
                    ? Image.network(
                        store.logoUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.store,
                          size: 40,
                          color: Colors.grey[400],
                        ),
                      )
                    : Icon(Icons.store, size: 40, color: Colors.grey[400]),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      store.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: store.isOpen
                              ? Colors.green
                              : colorScheme.error,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          store.isOpen ? 'باز' : 'بسته',
                          style: textTheme.bodySmall?.copyWith(
                            color: store.isOpen
                                ? Colors.green
                                : colorScheme.error,
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

  // ویجت برای نمایش خطا با دکمه تلاش مجدد
  Widget _buildErrorView(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off, color: Colors.grey[400], size: 60),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.read<StoreCubit>().fetchStores(),
            child: const Text('تلاش مجدد'),
          ),
        ],
      ),
    );
  }
}
