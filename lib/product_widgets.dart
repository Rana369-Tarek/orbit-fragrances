import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'main.dart';
import 'orbit_data.dart';

class OrbitProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onTap;

  const OrbitProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final name = product['name'] as String;
    final price = product['price'] as int;
    final image = product['image'] as String;
    final collection = product['collection'] as String;
    return Material(
      color: spaceSurface,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(image, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const ColoredBox(
                      color: spaceNavy,
                      child: Icon(Icons.auto_awesome, color: electricLavender, size: 36),
                    ),
                  ),
                  Positioned(
                    top: 9, right: 9,
                    child: ValueListenableBuilder<int>(
                      valueListenable: OrbitData.revision,
                      builder: (_, __, ___) => IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: spaceBlack.withValues(alpha: .78),
                          foregroundColor: OrbitData.isFavorite(name) ? Colors.pinkAccent : Colors.white,
                          minimumSize: const Size(36, 36),
                        ),
                        onPressed: () => OrbitData.toggleFavorite(name),
                        icon: Icon(OrbitData.isFavorite(name) ? Icons.favorite : Icons.favorite_border, size: 17),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10, top: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        color: spaceBlack.withValues(alpha: .75),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(collection, style: const TextStyle(fontSize: 7, letterSpacing: .7)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 11, 12, 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: starlightSilver, fontSize: 14, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 7),
                  Row(children: [
                    Text('\$$price', style: const TextStyle(color: orbitGold, fontSize: 14, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    const Icon(Icons.arrow_outward, color: lunarMist, size: 15),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrbitBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  const OrbitBottomNavigation({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final routes = ['/products', '/favorites', '/cart', '/profile'];
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) => context.go(routes[index]),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'Favorites'),
        NavigationDestination(icon: Icon(Icons.shopping_bag_outlined), selectedIcon: Icon(Icons.shopping_bag), label: 'Cart'),
        NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
