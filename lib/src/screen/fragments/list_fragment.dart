import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      child: Image.network(
          'https://www.nicepng.com/png/full/418-4187115_lady-cajero-png-meme-seora-tapando-png.png'),
    );
  }
}
