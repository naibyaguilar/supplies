import 'package:flutter/material.dart';

import '../models/models.dart';

class FarmCard extends StatelessWidget {
  final Farm farm;
  const FarmCard({super.key, required this.farm});
// (Size screenSize, BuildContext context, Farm myfarm)
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return InkWell(
      child: Container(
        decoration: _cardBorders(),
        height: screenSize.height * 0.10,
        margin: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: Column(
          children: [
            ListTile(
              title: Text(farm.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: screenSize.width * 0.05, color: Colors.white)),
              subtitle: Text(farm.address,
                  style: TextStyle(
                      fontSize: screenSize.width * 0.03, color: Colors.grey)),
              trailing: Text(farm.type,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.04,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  )),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
          color: const Color(0xEF007CFF),
          borderRadius: BorderRadius.circular(25),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            const BoxShadow(
                color: Colors.grey, offset: Offset(0, 7), blurRadius: 10)
          ]);
}
