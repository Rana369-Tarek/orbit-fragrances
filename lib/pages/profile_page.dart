import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';
import '../product_widgets.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({
    super.key,
    this.username = 'Guest',
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    print('ProfilePage: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('ProfilePage: didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print('ProfilePage: build');

    final isDark = orbitThemeMode.value == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'YOUR PROFILE',
          style: TextStyle(fontSize: 11, letterSpacing: 2),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(26),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              children: [
                Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cosmicIndigo,
                    border: Border.all(
                      color: electricLavender.withValues(alpha: .6),
                    ),
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    size: 42,
                    color: starlightSilver,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  widget.username.trim().isEmpty
                      ? 'ORBIT EXPLORER'
                      : widget.username.trim(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your fragrance journey, all in one place.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: lunarMist,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: SwitchListTile(
                    secondary: Icon(
                      isDark ? Icons.dark_mode : Icons.light_mode,
                      color: orbitGold,
                    ),
                    title: const Text(
                      'Appearance',
                      style: TextStyle(fontSize: 13),
                    ),
                    subtitle: Text(
                      isDark ? 'Dark mode' : 'Light mode',
                      style: const TextStyle(fontSize: 11),
                    ),
                    value: isDark,
                    activeThumbColor: orbitGold,
                    onChanged: (value) {
                      orbitThemeMode.value =
                          value ? ThemeMode.dark : ThemeMode.light;
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _tile(
                  Icons.favorite_border,
                  'My Favorites',
                  () => context.goNamed('favorites'),
                ),
                _tile(
                  Icons.shopping_bag_outlined,
                  'My Cart',
                  () => context.goNamed('cart'),
                ),
                _tile(
                  Icons.auto_awesome_outlined,
                  'Explore Collection',
                  () => context.goNamed('fragrances'),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () => context.goNamed('login'),
                    child: const Text(
                      'SIGN OUT',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const OrbitBottomNavigation(
        selectedIndex: 3,
      ),
    );
  }

  Widget _tile(
    IconData icon,
    String label,
    VoidCallback action,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(13),
      ),
      child: ListTile(
        leading: Icon(icon, color: electricLavender),
        title: Text(
          label,
          style: const TextStyle(fontSize: 13),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: lunarMist,
        ),
        onTap: action,
      ),
    );
  }

  @override
  void deactivate() {
    print('ProfilePage: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('ProfilePage: dispose');
    super.dispose();
  }
}
