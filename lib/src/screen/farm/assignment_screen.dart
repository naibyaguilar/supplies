import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class AssignScreen extends StatelessWidget {
  const AssignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: const Color(0xFFFFFFFF),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(screenSize.height / 8),
            child: Container()),
        flexibleSpace: ClipPath(
          clipper: CustomShape(),
          child: Container(
              height: screenSize.height / 2, // 157
              color: const Color(0xEF115DA9),
              child: Center(
                widthFactor: screenSize.width,
                child: ListTile(
                  title: Text(' ¡Hey!',
                      style: TextStyle(
                          fontSize: screenSize.width * 0.05,
                          color: Colors.white)),
                  subtitle: Text('          ¿Tienes esta actividad pendiente?',
                      style: TextStyle(
                          fontSize: screenSize.width * 0.04,
                          color: Colors.grey)),
                ),
              )),
        ),
      ),
      body: Container(),
    );
  }
}
