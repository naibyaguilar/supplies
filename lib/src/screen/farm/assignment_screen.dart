import 'dart:developer';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class AssignScreen extends StatelessWidget {
  const AssignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    log((screenSize.height / 5.5).toString());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: const Color(0xffCCE5FF),
      ),
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   toolbarHeight: screenSize.height / 6,

      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.vertical(
      //           // top: Radius.circular(screenSize.width / 2),
      //           bottom: Radius.circular(screenSize.width / 4))),
      //   elevation: 0,
      //   backgroundColor: const Color(0xEF115DA9),
      //   title: const FittedBox(
      //       fit: BoxFit.fitWidth,
      //       child: Padding(
      //         padding: EdgeInsets.all(8.0),
      //         child: Text(
      //           'Hola _persona.name, \n tienes algún pendiente...',
      //           textAlign: TextAlign.center,
      //         ),
      //       )),
      // ),
    );
  }
}
