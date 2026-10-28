import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';
import '../orbit_data.dart';
import '../product_widgets.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    print('CartPage: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('CartPage: didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print('CartPage: build');
    return ValueListenableBuilder<int>(valueListenable: OrbitData.revision, builder: (context, _, __) {
      final entries = OrbitData.cart.entries.toList();
      final subtotal = entries.fold<int>(0, (sum, entry) {
        final product = OrbitData.productByName(entry.key);
        return sum + (product['price'] as int) * entry.value;
      });
      const shipping = 8;
      final total = subtotal == 0 ? 0 : subtotal + shipping;
      return Scaffold(
        appBar: AppBar(title: const Text('YOUR CART', style: TextStyle(fontSize: 11, letterSpacing: 2))),
        body: entries.isEmpty
          ? Center(child: Padding(padding: const EdgeInsets.all(28), child: Column(
              mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.shopping_bag_outlined, size: 48, color: electricLavender),
                const SizedBox(height: 18),
                const Text('Your cart is orbiting empty', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                const SizedBox(height: 9),
                const Text('Discover a fragrance to begin your collection.', textAlign: TextAlign.center,
                  style: TextStyle(color: lunarMist, fontSize: 12)),
                const SizedBox(height: 20),
                FilledButton(onPressed: () => context.goNamed('fragrances'), child: const Text('EXPLORE COLLECTION')),
              ],
            )))
          : ListView(padding: const EdgeInsets.fromLTRB(18, 12, 18, 28), children: [
              ...entries.map((entry) {
                final product = OrbitData.productByName(entry.key);
                return Container(
                  margin: const EdgeInsets.only(bottom: 13),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: spaceSurface, borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: const Color(0xFF292E49))),
                  child: Row(children: [
                    ClipRRect(borderRadius: BorderRadius.circular(10), child: SizedBox(
                      width: 86, height: 105, child: Image.asset(product['image'], fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const ColoredBox(color: spaceNavy, child: Icon(Icons.auto_awesome))))),
                    const SizedBox(width: 13),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(product['name'], style: const TextStyle(fontSize: 15)),
                      const SizedBox(height: 8),
                      Text('\$${product['price']}', style: const TextStyle(color: orbitGold, fontSize: 14)),
                      const SizedBox(height: 10),
                      Row(children: [
                        _quantityButton(Icons.remove, () => OrbitData.changeQuantity(entry.key, -1)),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text('${entry.value}')),
                        _quantityButton(Icons.add, () => OrbitData.changeQuantity(entry.key, 1)),
                        const Spacer(),
                        IconButton(onPressed: () => OrbitData.removeFromCart(entry.key),
                          icon: const Icon(Icons.delete_outline, color: lunarMist, size: 20)),
                      ]),
                    ])),
                  ]),
                );
              }),
              const SizedBox(height: 15),
              _summary('Subtotal', subtotal),
              _summary('Shipping', subtotal == 0 ? 0 : shipping),
              const Divider(height: 28, color: Color(0xFF343452)),
              _summary('Total', total, strong: true),
              const SizedBox(height: 20),
              SizedBox(height: 52, child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: nebulaViolet),
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Checkout is a visual demo and is not connected to payment.'))),
                child: const Text('PROCEED TO CHECKOUT', style: TextStyle(fontSize: 10, letterSpacing: 1.5)),
              )),
            ]),
        bottomNavigationBar: const OrbitBottomNavigation(selectedIndex: 2),
      );
    });
  }

  Widget _quantityButton(IconData icon, VoidCallback onPressed) => SizedBox(
    width: 29, height: 29, child: IconButton(
      padding: EdgeInsets.zero, onPressed: onPressed, icon: Icon(icon, size: 15),
      style: IconButton.styleFrom(backgroundColor: const Color(0xFF25213F), foregroundColor: starlightSilver),
    ));

  Widget _summary(String title, int amount, {bool strong = false}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(children: [
      Text(title, style: TextStyle(color: strong ? starlightSilver : lunarMist, fontSize: strong ? 14 : 12)),
      const Spacer(),
      Text('\$$amount', style: TextStyle(color: strong ? orbitGold : starlightSilver,
        fontSize: strong ? 18 : 12, fontWeight: strong ? FontWeight.w600 : FontWeight.normal)),
    ]),
  );

  @override
  void deactivate() {
    print('CartPage: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('CartPage: dispose');
    super.dispose();
  }
}
