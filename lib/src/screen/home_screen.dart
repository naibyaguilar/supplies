import 'package:flutter/material.dart';
import 'package:supplies/src/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          AppBarHome(),
        ],
      ),
    );
  }
}
