import 'package:flutter/cupertino.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/wave.png',
                  ),
                  fit: BoxFit.fitHeight)),
        )
      ],
    );
  }
}
