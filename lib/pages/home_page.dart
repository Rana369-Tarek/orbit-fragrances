import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';
import '../orbit_data.dart';
import '../product_widgets.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  void initState() {
    super.initState();
    print('HomePage: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.sizeOf(context);
    screenWidth = size.width;
    screenHeight = size.height;
    print('HomePage: didChangeDependencies width=$screenWidth height=$screenHeight');
  }

  @override
  Widget build(BuildContext context) {
    print('HomePage: build');
    final width = MediaQuery.sizeOf(context).width;
    final wide = width >= 850;
    final featured = OrbitData.products.take(8).toList();
    return Scaffold(
      body: SafeArea(child: CustomScrollView(slivers: [
        SliverToBoxAdapter(child: Padding(
          padding: EdgeInsets.symmetric(horizontal: wide ? 46 : 20, vertical: 17),
          child: Row(children: [
            const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('ORBIT', style: TextStyle(fontSize: 23, letterSpacing: 5, fontWeight: FontWeight.w300)),
              Text('F R A G R A N C E S', style: TextStyle(fontSize: 7, letterSpacing: 2, color: lunarMist)),
            ]),
            const Spacer(),
            if (wide) ...[
              TextButton(onPressed: () => context.goNamed('products', queryParameters: {'user': widget.username}), child: const Text('HOME')),
              TextButton(onPressed: () => context.goNamed('fragrances'), child: const Text('COLLECTION')),
              TextButton(onPressed: () => context.goNamed('favorites'), child: const Text('FAVORITES')),
            ],
            IconButton(onPressed: () => context.goNamed('fragrances'), icon: const Icon(Icons.search)),
            ValueListenableBuilder<int>(valueListenable: OrbitData.revision, builder: (_, __, ___) =>
              IconButton(onPressed: () => context.goNamed('cart'), icon: Badge(
                label: Text('${OrbitData.cart.values.fold<int>(0, (a, b) => a + b)}'),
                isLabelVisible: OrbitData.cart.isNotEmpty,
                child: const Icon(Icons.shopping_bag_outlined)))),
          ]),
        )),
        SliverToBoxAdapter(child: Padding(
          padding: EdgeInsets.symmetric(horizontal: wide ? 46 : 20),
          child: ClipRRect(borderRadius: BorderRadius.circular(22), child: SizedBox(
            height: wide ? 430 : 380, width: double.infinity,
            child: Stack(fit: StackFit.expand, children: [
              Image.asset('assets/images/home_hero.jpg', fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const ColoredBox(color: cosmicIndigo)),
              const DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(
                begin: Alignment.centerLeft, end: Alignment.centerRight,
                colors: [Color(0xE8070912), Color(0x77070912), Color(0x11070912)]))),
              Padding(padding: EdgeInsets.all(wide ? 42 : 24), child: Align(
                alignment: Alignment.centerLeft, child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('SCENT FROM ANOTHER WORLD', style: TextStyle(
                      color: electricLavender, fontSize: 9, letterSpacing: 2.2)),
                    const SizedBox(height: 17),
                    Text('Discover your\nown universe.', style: TextStyle(
                      fontSize: wide ? 43 : 33, height: 1.17, fontWeight: FontWeight.w300)),
                    const SizedBox(height: 14),
                    const Text('Explore distinctive fragrances inspired by the beauty and mystery of space.',
                      style: TextStyle(color: starlightSilver, fontSize: 12, height: 1.7)),
                    const SizedBox(height: 24),
                    FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: nebulaViolet, padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 17)),
                      onPressed: () => context.goNamed('fragrances'),
                      child: const Text('EXPLORE COLLECTION', style: TextStyle(fontSize: 10, letterSpacing: 1.3)),
                    ),
                  ]),
                ),
              )),
            ]),
          )),
        )),
        SliverToBoxAdapter(child: Padding(
          padding: EdgeInsets.fromLTRB(wide ? 46 : 20, 32, wide ? 46 : 20, 16),
          child: Row(children: [
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('THE COLLECTION', style: TextStyle(color: electricLavender, fontSize: 8, letterSpacing: 2)),
              SizedBox(height: 7),
              Text('Featured Fragrances', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w300)),
            ])),
            TextButton(onPressed: () => context.goNamed('fragrances'),
              child: const Text('VIEW ALL  →', style: TextStyle(color: electricLavender, fontSize: 9, letterSpacing: 1))),
          ]),
        )),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: wide ? 46 : 20),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => OrbitProductCard(
                product: featured[index],
                onTap: () => context.pushNamed('details',
                  pathParameters: {'name': featured[index]['name'], 'price': '${featured[index]['price']}'},
                  extra: featured[index]),
              ),
              childCount: featured.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: width >= 1200 ? 4 : width >= 800 ? 3 : width >= 520 ? 2 : 2,
              crossAxisSpacing: 14, mainAxisSpacing: 16, childAspectRatio: .66,
            ),
          ),
        ),
        SliverToBoxAdapter(child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(child: Text('Screen width: ${screenWidth.toStringAsFixed(0)} px',
            style: const TextStyle(color: lunarMist, fontSize: 9))),
        )),
      ])),
      bottomNavigationBar: const OrbitBottomNavigation(selectedIndex: 0),
    );
  }

  @override
  void deactivate() {
    print('HomePage: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('HomePage: dispose');
    super.dispose();
  }
}
