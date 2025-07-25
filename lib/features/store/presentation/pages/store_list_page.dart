// lib/features/store/presentation/pages/store_list_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:customer_app/features/promotion/domain/entities/promotion_entity.dart';
import 'package:customer_app/features/store/presentation/cubit/dashboard_cubit.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/entities/store_entity.dart';
import '../../../product/presentation/pages/product_list_page.dart';

// مدل دسته‌بندی را برای استفاده از عکس به‌روز می‌کنیم
class Category {
  final String name;
  final String imageUrl;
  Category({required this.name, required this.imageUrl});
}

class StoreListPage extends StatefulWidget {
  const StoreListPage({super.key});

  @override
  State<StoreListPage> createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  final _pageController = PageController(viewportFraction: 0.9);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => sl<DashboardCubit>()..fetchDashboardData(),
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state.status == DashboardStatus.loading &&
                state.stores.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == DashboardStatus.failure) {
              return Center(child: Text(state.errorMessage ?? 'خطایی رخ داد'));
            }
            return RefreshIndicator(
              onRefresh: () async =>
                  context.read<DashboardCubit>().fetchDashboardData(),
              child: CustomScrollView(
                slivers: [
                  _buildSliverAppBar(context),
                  _buildSectionTitle('دسته‌بندی‌ها'),
                  _buildCategoriesSliver(),
                  _buildSectionTitle('پیشنهادهای ویژه'),
                  _buildPromotionsSliver(context, state.promotions),
                  _buildSectionTitle('همه فروشگاه‌ها'),
                  _buildStoresGrid(context, state.stores),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // --- AppBar با قابلیت شناور شدن ---
  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      floating: true, // با اسکرول به بالا ظاهر می‌شود
      snap: true, // به صورت کامل ظاهر یا پنهان می‌شود
      pinned: false, // در بالای صفحه ثابت نمی‌ماند
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0.5,
      title: const Text(
        'فود اپ',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ).copyWith(bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'جستجو در میان رستوران‌ها...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSectionTitle(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // --- طراحی جدید و جذاب برای دسته‌بندی‌ها ---
  SliverToBoxAdapter _buildCategoriesSliver() {
    final List<Category> categories = [
      Category(
        name: 'برگر',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3075/3075977.png',
      ),
      Category(
        name: 'پیتزا',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/1404/1404945.png',
      ),
      Category(
        name: 'ایرانی',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/9029/9029938.png',
      ),
      Category(
        name: 'کافه',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/924/924514.png',
      ),
      Category(
        name: 'آسیایی',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/4060/4060226.png',
      ),
    ];

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 110.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.network(
                      category.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildPromotionsSliver(
    BuildContext context,
    List<PromotionEntity> promotions,
  ) {
    if (promotions.isEmpty)
      return const SliverToBoxAdapter(child: SizedBox.shrink());

    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(
            height: 160.0,
            child: PageView.builder(
              controller: _pageController,
              itemCount: promotions.length,
              itemBuilder: (context, index) {
                final promotion = promotions[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(promotion.imageUrl, fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          SmoothPageIndicator(
            controller: _pageController,
            count: promotions.length,
            effect: ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Theme.of(context).colorScheme.primary,
              paintStyle: PaintingStyle.fill,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoresGrid(BuildContext context, List<StoreEntity> stores) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = (screenWidth > 600) ? 3 : 2;

    return AnimationLimiter(
      child: SliverPadding(
        padding: const EdgeInsets.all(16.0),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.82,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 375),
              columnCount: crossAxisCount,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: _buildStoreCard(context, stores[index]),
                ),
              ),
            );
          }, childCount: stores.length),
        ),
      ),
    );
  }

  Widget _buildStoreCard(BuildContext context, StoreEntity store) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              ProductListPage(storeId: store.id, storeName: store.name),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  store.logoUrl ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Center(
                    child: Icon(Icons.store, color: Colors.grey[300], size: 40),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      store.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      store.cuisineType,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber.shade700,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          store.rating.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' (${store.ratingCount})',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          store.deliveryTimeEstimate,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(
                          Icons.timer_outlined,
                          size: 14,
                          color: Colors.grey,
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
}
