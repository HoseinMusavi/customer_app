// lib/main.dart

import 'package:flutter/material.dart';
import 'core/di/service_locator.dart' as di;
import 'features/customer/presentation/pages/customer_profile_page.dart'; // <-- صفحه جدید را import کنید

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false, // بنر دیباگ را حذف می‌کند
      home:
          const CustomerProfilePage(), // <-- صفحه اصلی را به CustomerProfilePage تغییر دهید
    );
  }
}
