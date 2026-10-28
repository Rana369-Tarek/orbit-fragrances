import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final AnimationController controller;
  late final Animation<double> fade;
  bool rememberMe = true;
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    print('LoginPage: initState');
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    fade = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('LoginPage: didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print('LoginPage: build');
    final width = MediaQuery.sizeOf(context).width;
    final wide = width >= 850;

return Scaffold(
  body: SafeArea(
    child: FadeTransition(
      opacity: fade,
      child: wide
          ? Row(
              children: [
                Expanded(
                  flex: 6,
                  child: _visualPanel(height: double.infinity),
                ),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 410),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(34),
                        child: _form(),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: _visualPanel(height: 300),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 26, 24, 35),
                    child: _form(),
                  ),
                ],
              ),
            ),
    ),
  ),
);

  }

  Widget _visualPanel({required double height}) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(fit: StackFit.expand, children: [
        Image.asset('assets/images/login_background.png', fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const DecoratedBox(decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: [spaceBlack, cosmicIndigo, spaceNavy])))),
        const DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Color(0x33070912), Color(0xD9070912)]))),
        Padding(padding: const EdgeInsets.all(25), child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('O R B I T', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w300, letterSpacing: 6)),
            const Text('F R A G R A N C E S', style: TextStyle(fontSize: 8, letterSpacing: 2.5, color: starlightSilver)),
            const Spacer(),
            const Text('SCENT FROM\nANOTHER WORLD', style: TextStyle(
              fontSize: 34, height: 1.25, fontWeight: FontWeight.w300, letterSpacing: 1.3)),
            const SizedBox(height: 12),
            const Text('Fragrances that take you beyond the ordinary.',
              style: TextStyle(color: starlightSilver, fontSize: 13)),
            const SizedBox(height: 15),
          ],
        )),
      ]),
    );
  }

  Widget _form() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('YOUR JOURNEY STARTS HERE', style: TextStyle(
        color: electricLavender, fontSize: 9, letterSpacing: 2.2)),
      const SizedBox(height: 14),
      const Text('Enter your\nuniverse.', style: TextStyle(
        fontSize: 36, height: 1.15, fontWeight: FontWeight.w300)),
      const SizedBox(height: 12),
      const Text('Sign in to discover your next signature scent.',
        style: TextStyle(color: lunarMist, fontSize: 13, height: 1.6)),
      const SizedBox(height: 28),
      const Text('EMAIL ADDRESS', style: TextStyle(fontSize: 9, letterSpacing: 1.7)),
      const SizedBox(height: 9),
      TextField(controller: emailController, keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(hintText: 'Enter your email', prefixIcon: Icon(Icons.mail_outline))),
      const SizedBox(height: 18),
      const Text('PASSWORD', style: TextStyle(fontSize: 9, letterSpacing: 1.7)),
      const SizedBox(height: 9),
      TextField(controller: passwordController, obscureText: obscurePassword,
        decoration: InputDecoration(hintText: 'Enter your password', prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(onPressed: () => setState(() => obscurePassword = !obscurePassword),
            icon: Icon(obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined)))),
      const SizedBox(height: 12),
      Row(children: [
        Checkbox(value: rememberMe, onChanged: (v) => setState(() => rememberMe = v ?? false),
          activeColor: nebulaViolet),
        const Text('Remember me', style: TextStyle(color: lunarMist, fontSize: 11)),
        const Spacer(),
        TextButton(onPressed: () => _message('Password recovery is not connected yet.'),
          child: const Text('Forgot password?', style: TextStyle(color: electricLavender, fontSize: 10))),
      ]),
      const SizedBox(height: 13),
      SizedBox(width: double.infinity, height: 52, child: DecoratedBox(
        decoration: BoxDecoration(gradient: const LinearGradient(colors: [nebulaViolet, cosmicIndigo]),
          borderRadius: BorderRadius.circular(13)),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
          onPressed: _login,
          child: const Text('SIGN IN', style: TextStyle(letterSpacing: 2, fontSize: 11, fontWeight: FontWeight.w600)),
        ),
      )),
      const SizedBox(height: 19),
      Center(child: Wrap(alignment: WrapAlignment.center, children: [
        const Text('New to ORBIT? ', style: TextStyle(color: lunarMist, fontSize: 11)),
        GestureDetector(onTap: () => _message('Guest access is available. Create-account service is not connected.'),
          child: const Text('Create an account', style: TextStyle(color: electricLavender, fontSize: 11))),
      ])),
      const SizedBox(height: 25),
      const Center(child: Text('A DISTINCTIVE SCENT. YOUR OWN UNIVERSE.',
        textAlign: TextAlign.center, style: TextStyle(color: lunarMist, fontSize: 8, letterSpacing: 1.1))),
    ]);
  }

  void _login() {
    final email = emailController.text.trim();
    final user = email.isEmpty ? 'Guest' : email.split('@').first;
    context.goNamed('products', queryParameters: {'user': user});
  }

  void _message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  void deactivate() {
    print('LoginPage: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('LoginPage: dispose');
    controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
