import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> fade;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    print('SplashPage: initState');
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
    fade = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    controller.forward();
    timer = Timer(const Duration(seconds: 7), () {
      if (mounted) context.goNamed('login');
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('SplashPage: didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print('SplashPage: build');
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Image.asset('assets/images/splash_background.png', fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const DecoratedBox(decoration: BoxDecoration(
            gradient: RadialGradient(colors: [cosmicIndigo, spaceNavy, spaceBlack])))),
        const DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Color(0x44030918), Color(0xE8070912)]))),
        SafeArea(child: Center(child: FadeTransition(opacity: fade, child: Column(
          mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('O R B I T', style: TextStyle(fontSize: 43, fontWeight: FontWeight.w300, letterSpacing: 9)),
            const SizedBox(height: 9),
            const Text('F R A G R A N C E S', style: TextStyle(fontSize: 10, letterSpacing: 4, color: starlightSilver)),
            const SizedBox(height: 32),
            Container(width: 60, height: 1, color: orbitGold),
            const SizedBox(height: 25),
            const Text('BEYOND THE ORDINARY.', style: TextStyle(fontSize: 10, letterSpacing: 2.2)),
            const SizedBox(height: 10),
            const Text('DISCOVER YOUR UNIVERSE.', style: TextStyle(fontSize: 10, letterSpacing: 2.2)),
            const SizedBox(height: 52),
            const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 1.4, color: electricLavender)),
          ],
        )))),
        const Positioned(bottom: 25, left: 15, right: 15, child: Text(
          'A DISTINCTIVE SCENT. YOUR OWN UNIVERSE.', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 8, letterSpacing: 1.3, color: lunarMist))),
      ]),
    );
  }

  @override
  void deactivate() {
    print('SplashPage: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('SplashPage: dispose');
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }
}
