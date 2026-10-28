import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';
import '../orbit_data.dart';
import '../product_widgets.dart';

class AllFragrancesPage extends StatefulWidget {
  const AllFragrancesPage({super.key});

  @override
  State<AllFragrancesPage> createState() => _AllFragrancesPageState();
}

class _AllFragrancesPageState extends State<AllFragrancesPage> {
  final TextEditingController searchController = TextEditingController();
  String category = 'ALL';

  @override
  void initState() {
    super.initState();
    print('AllFragrancesPage: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('AllFragrancesPage: didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print('AllFragrancesPage: build');

    final categories = [
      'ALL',
      'LUNAR COLLECTION',
      'SOLAR COLLECTION',
      'GALAXY COLLECTION',
      'DARK COLLECTION',
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.goNamed('products'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'ALL FRAGRANCES',
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.goNamed('favorites'),
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 12),
            child: TextField(
              controller: searchController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search fragrances',
              ),
            ),
          ),
          SizedBox(
            height: 46,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              scrollDirection: Axis.horizontal,
              children: categories.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      item,
                      style: const TextStyle(fontSize: 9),
                    ),
                    selected: category == item,
                    onSelected: (_) {
                      setState(() {
                        category = item;
                      });
                    },
                    selectedColor: nebulaViolet,
                    backgroundColor: spaceSurface,
                    side: BorderSide(
                      color: category == item
                          ? nebulaViolet
                          : const Color(0xFF303956),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;

                final columns = width >= 1100
                    ? 4
                    : width >= 750
                        ? 3
                        : 2;

                final items = OrbitData.products.where((product) {
                  final name = product['name'].toString().toLowerCase();
                  final query = searchController.text.toLowerCase();

                  final matchesText = name.contains(query);

                  final matchesCategory = category == 'ALL' ||
                      product['collection'] == category;

                  return matchesText && matchesCategory;
                }).toList();

                if (items.isEmpty) {
                  return const Center(
                    child: Text(
                      'No fragrances found',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                  itemCount: items.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 13,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final product = items[index];

                    return OrbitProductCard(
                      product: product,
                      onTap: () {
                        context.pushNamed(
                          'details',
                          pathParameters: {
                            'name': product['name'].toString(),
                            'price': product['price'].toString(),
                          },
                          extra: product,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const OrbitBottomNavigation(
        selectedIndex: 0,
      ),
    );
  }

  @override
  void deactivate() {
    print('AllFragrancesPage: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('AllFragrancesPage: dispose');
    searchController.dispose();
    super.dispose();
  }
}
