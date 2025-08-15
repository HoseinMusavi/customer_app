// lib/main.dart

import 'package:customer_app/main_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/di/service_locator.dart' as di;
import 'core/theme/app_theme.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // --- CHANGE START: Supabase Initialization ---
  await Supabase.initialize(
    // TODO: Replace with your Supabase URL
    url: 'https://zjtnzzammmyuagxatwgf.supabase.co',
    // TODO: Replace with your Supabase Anon Key
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpqdG56emFtbW15dWFneGF0d2dmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQwNzI5NjksImV4cCI6MjA2OTY0ODk2OX0.arRyVtvhA0w5xdopkQC8bRZ0hnKKtIJIaXtYkoKMbJw',
  );
  // --- CHANGE END ---

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<CartBloc>()..add(CartStarted()),
      child: MaterialApp(
        title: 'فود اپ',
        debugShowCheckedModeBanner: false,
        locale: const Locale('fa', 'IR'),
        supportedLocales: const [Locale('fa', 'IR')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: AppTheme.lightTheme,
        home: const MainShell(),
      ),
    );
  }
}
