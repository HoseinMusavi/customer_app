// در مسیر: lib/main.dart
import 'package:flutter/material.dart';
import 'core/di/service_locator.dart' as di;
import 'features/customer/presentation/pages/customer_profile_page.dart'; // یا هر صفحه دیگری که می‌خواهید اول نمایش داده شود

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // <-- این خط تابع init را فراخوانی می‌کند
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      debugShowCheckedModeBanner: false,
      home: const CustomerProfilePage(),
    );
  }
}
