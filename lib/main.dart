/*
PART 1: LIFECYCLE

1. When you first open a page, which lifecycle methods run?
initState(), didChangeDependencies(), and build() run when a StatefulWidget is first created. initState() runs once for that State object, while didChangeDependencies() and build() may run again later.

2. Which method runs again when you tap the heart button?
setState() triggers build() to run again and update the UI. initState() does not run again.

3. When you leave a page or press Back, which methods run?
deactivate() runs when the State object is removed from the widget tree. dispose() runs when the State object is permanently removed. The exact sequence depends on how navigation changes the widget tree.

4. When you resize the browser window, which methods run and why?
build() runs again when the widget needs to rebuild because the screen dimensions change. didChangeDependencies() can also run again because the widget depends on MediaQuery, which provides the screen dimensions.


PART 4: GOROUTER

1. What is the difference between context.go() and context.push()? Give an example of each.
context.go() navigates to a location and updates the current navigation stack to match that route. context.push() adds a new route on top of the current route.
Example: context.go('/products') navigates to the products page, while context.push('/details/Luna/85') opens product details on top of the current page.

2. Why do we use go for Login -> Products and push for Product Details?
We use go for Login -> Products because the user should not return to the login page using the Back button after logging in. We use push for Product Details because the user should be able to return to the products page.

3. What is the difference between path parameters and query parameters? Give an example.
Path parameters are part of the URL path and identify a specific resource. Query parameters are added after a question mark and provide additional information.
Example of path parameters: /details/Luna/85, where Luna is the product name and 85 is its price.
Example of a query parameter: /products?user=Guest, where user identifies the current username.
*/

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
