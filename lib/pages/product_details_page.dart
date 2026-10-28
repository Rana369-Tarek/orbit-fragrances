import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';
import '../orbit_data.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productName;
  final int productPrice;
  final Map<String, dynamic>? product;
  const ProductDetailsPage({super.key, required this.productName, required this.productPrice, this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    super.initState();
    print('ProductDetailsPage: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('ProductDetailsPage: didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print('ProductDetailsPage: build');
    final product = widget.product ?? OrbitData.productByName(widget.productName);
    final image = product['image'] as String;
    final name = product['name'] as String;
    final price = product['price'] as int;
    final notes = (product['notes'] as String).split(', ');
    final width = MediaQuery.sizeOf(context).width;
    final wide = width >= 760;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
        title: const Text('FRAGRANCE DETAILS', style: TextStyle(fontSize: 11, letterSpacing: 2)),
        actions: [IconButton(onPressed: () => context.goNamed('cart'), icon: const Icon(Icons.shopping_bag_outlined))],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: wide ? 55 : 20, vertical: 18),
        child: Center(child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: wide ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: _image(image, 560)),
            const SizedBox(width: 42),
            Expanded(child: _details(product, name, price, notes)),
          ]) : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _image(image, 390),
            const SizedBox(height: 25),
            _details(product, name, price, notes),
          ]),
        )),
      ),
    );
  }

  Widget _image(String path, double height) => ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: SizedBox(width: double.infinity, height: height, child: Image.asset(path, fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const ColoredBox(color: spaceNavy, child: Icon(Icons.auto_awesome, size: 45, color: electricLavender)))),
  );

  Widget _details(Map<String, dynamic> product, String name, int price, List<String> notes) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(product['collection'] as String, style: const TextStyle(color: electricLavender, fontSize: 9, letterSpacing: 2)),
      const SizedBox(height: 12),
      Text(name, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w300, letterSpacing: .6)),
      const SizedBox(height: 10),
      const Row(children: [
        Icon(Icons.star, color: orbitGold, size: 17), SizedBox(width: 5),
        Text('4.8', style: TextStyle(color: starlightSilver, fontSize: 12)),
        SizedBox(width: 8),
        Text('(Customer-inspired rating)', style: TextStyle(color: lunarMist, fontSize: 10)),
      ]),
      const SizedBox(height: 20),
      Text('\$$price', style: const TextStyle(color: orbitGold, fontSize: 25, fontWeight: FontWeight.w500)),
      const SizedBox(height: 20),
      Text(product['description'] as String, style: const TextStyle(color: lunarMist, fontSize: 13, height: 1.8)),
      const SizedBox(height: 28),
      const Text('FRAGRANCE NOTES', style: TextStyle(fontSize: 10, letterSpacing: 1.8)),
      const SizedBox(height: 12),
      Wrap(spacing: 8, runSpacing: 8, children: notes.map((note) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
        decoration: BoxDecoration(color: spaceSurface, borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFF343452))),
        child: Text(note, style: const TextStyle(color: starlightSilver, fontSize: 10)),
      )).toList()),
      const SizedBox(height: 32),
      SizedBox(width: double.infinity, height: 54, child: FilledButton(
        style: FilledButton.styleFrom(backgroundColor: nebulaViolet, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))),
        onPressed: () {
          OrbitData.addToCart(name);
          context.pop('$name added to cart');
        },
        child: const Text('ADD TO CART', style: TextStyle(fontSize: 11, letterSpacing: 2)),
      )),
      const SizedBox(height: 12),
      SizedBox(width: double.infinity, height: 48, child: OutlinedButton(
        style: OutlinedButton.styleFrom(foregroundColor: starlightSilver, side: const BorderSide(color: Color(0xFF343452))),
        onPressed: () => OrbitData.toggleFavorite(name),
        child: const Text('ADD TO FAVORITES', style: TextStyle(fontSize: 10, letterSpacing: 1.3)),
      )),
    ]);
  }

  @override
  void deactivate() {
    print('ProductDetailsPage: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('ProductDetailsPage: dispose');
    super.dispose();
  }
}
