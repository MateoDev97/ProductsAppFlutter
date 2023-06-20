import 'package:flutter/material.dart';
import 'package:products_app/providers/products_provider.dart';
import 'package:products_app/theme/app_theme.dart';
import 'package:products_app/views/views.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsProvider()
        )
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const MaterialColor primaryColor = Colors.orange;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'login': (_) => const LoginView(),
        'home': (_) => const HomeView(),
        'product': (_) => const ProductView(),
      },
      theme: AppTheme.lightTheme,
    );
  }
}
