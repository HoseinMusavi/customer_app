// lib/main_shell.dart

import 'package:flutter/material.dart';
import 'features/cart/presentation/pages/cart_page.dart';
import 'features/cart/presentation/pages/order_tracking_page.dart';
import 'features/customer/presentation/pages/customer_profile_page.dart';
import 'features/store/presentation/pages/store_list_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    StoreListPage(),
    CartPage(),
    OrderTrackingPage(),
    CustomerProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // بدنه‌ی Scaffold صفحه‌ای است که بر اساس تب انتخاب شده نمایش داده می‌شود
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            activeIcon: Icon(Icons.storefront),
            label: 'فروشگاه',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'سبد خرید',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'پیگیری',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'حساب',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // این تنظیمات برای نمایش صحیح تب‌ها وقتی تعدادشان زیاد است، ضروری است
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
      ),
    );
  }
}
