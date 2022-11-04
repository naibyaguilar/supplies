import 'package:flutter/material.dart';
import 'package:supplies/src/screen/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Supplies',
      theme: ThemeData(
        primaryColor: const Color(0xEF007CFF),
      ),
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'login': (_) => const LoginScreen(),
        'register': (_) => const RegisterScreen()
      },
    );
  }
}
