import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';
import '../orbit_data.dart';
import '../product_widgets.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    print('FavoritesPage: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('FavoritesPage: didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print('FavoritesPage: build');
    return ValueListenableBuilder<int>(valueListenable: OrbitData.revision, builder: (context, _, __) {
      final products = OrbitData.products.where((p) => OrbitData.isFavorite(p['name'] as String)).toList();
      final width = MediaQuery.sizeOf(context).width;
      final columns = width >= 1100 ? 4 : width >= 750 ? 3 : 2;
      return Scaffold(
        appBar: AppBar(title: const Text('YOUR FAVORITES', style: TextStyle(fontSize: 11, letterSpacing: 2))),
        body: products.isEmpty
          ? Center(child: Padding(padding: const EdgeInsets.all(28), child: Column(
              mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.favorite_border, size: 48, color: electricLavender),
                const SizedBox(height: 18),
                const Text('Your universe is waiting', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                const SizedBox(height: 9),
                const Text('Save fragrances you love and find them here.', textAlign: TextAlign.center,
                  style: TextStyle(color: lunarMist, fontSize: 12)),
                const SizedBox(height: 20),
                FilledButton(onPressed: () => context.goNamed('fragrances'), child: const Text('EXPLORE FRAGRANCES')),
              ],
            )))
          : GridView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns, crossAxisSpacing: 13, mainAxisSpacing: 15, childAspectRatio: .65),
              itemBuilder: (context, index) => OrbitProductCard(
                product: products[index],
                onTap: () => context.pushNamed('details',
                  pathParameters: {'name': products[index]['name'], 'price': '${products[index]['price']}'},
                  extra: products[index]),
              ),
            ),
        bottomNavigationBar: const OrbitBottomNavigation(selectedIndex: 1),
      );
    });
  }

  @override
  void deactivate() {
    print('FavoritesPage: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('FavoritesPage: dispose');
    super.dispose();
  }
}
