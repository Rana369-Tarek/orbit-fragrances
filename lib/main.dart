import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/all_fragrances_page.dart';
import 'pages/product_details_page.dart';
import 'pages/favorites_page.dart';
import 'pages/cart_page.dart';
import 'pages/profile_page.dart';

const Color spaceBlack = Color(0xFF070912);
const Color spaceNavy = Color(0xFF10182B);
const Color spaceSurface = Color(0xFF111526);
const Color cosmicIndigo = Color(0xFF292653);
const Color nebulaViolet = Color(0xFF7654B8);
const Color electricLavender = Color(0xFFB6A0FF);
const Color starlightSilver = Color(0xFFD9E0F2);
const Color lunarMist = Color(0xFF858BA7);
const Color orbitGold = Color(0xFFD6B675);

final ValueNotifier<ThemeMode> orbitThemeMode =
    ValueNotifier<ThemeMode>(ThemeMode.dark);

void main() {
  runApp(const OrbitFragrancesApp());
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/products',
      name: 'products',
      builder: (context, state) => HomePage(
        username: state.uri.queryParameters['user'] ?? 'Guest',
      ),
    ),
    GoRoute(
      path: '/fragrances',
      name: 'fragrances',
      builder: (context, state) => const AllFragrancesPage(),
    ),
    GoRoute(
      path: '/favorites',
      name: 'favorites',
      builder: (context, state) => const FavoritesPage(),
    ),
    GoRoute(
      path: '/cart',
      name: 'cart',
      builder: (context, state) => const CartPage(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => ProfilePage(
        username: state.uri.queryParameters['user'] ?? 'Guest',
      ),
    ),
    GoRoute(
      path: '/details/:name/:price',
      name: 'details',
      builder: (context, state) => ProductDetailsPage(
        productName: state.pathParameters['name'] ?? 'Luna',
        productPrice:
            int.tryParse(state.pathParameters['price'] ?? '') ?? 85,
        product: state.extra as Map<String, dynamic>?,
      ),
    ),
  ],
);

class OrbitFragrancesApp extends StatelessWidget {
  const OrbitFragrancesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: orbitThemeMode,
      builder: (context, mode, child) {
        return MaterialApp.router(
          title: 'ORBIT Fragrances',
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          routerConfig: appRouter,

          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: spaceBlack,
            colorScheme: const ColorScheme.dark(
              primary: nebulaViolet,
              secondary: electricLavender,
              surface: spaceSurface,
              onPrimary: Colors.white,
              onSurface: starlightSilver,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: spaceBlack,
              foregroundColor: starlightSilver,
              elevation: 0,
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: spaceNavy.withValues(alpha: 0.88),
              hintStyle: const TextStyle(
                color: lunarMist,
                fontSize: 13,
              ),
              prefixIconColor: lunarMist,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 17,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFF303956),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: electricLavender,
                  width: 1.2,
                ),
              ),
            ),
          ),

          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF6F3FA),
            colorScheme: const ColorScheme.light(
              primary: nebulaViolet,
              secondary: cosmicIndigo,
              surface: Colors.white,
              onPrimary: Colors.white,
              onSurface: Color(0xFF17152A),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFFF6F3FA),
              foregroundColor: Color(0xFF17152A),
              elevation: 0,
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xFFECE7F4),
              hintStyle: const TextStyle(
                color: Color(0xFF777187),
                fontSize: 13,
              ),
              prefixIconColor: nebulaViolet,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 17,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFFD8CDE9),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: nebulaViolet,
                  width: 1.2,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
