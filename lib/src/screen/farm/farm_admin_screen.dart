import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class FarmAdminScreen extends StatelessWidget {
  const FarmAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: const Color(0xffCCE5FF),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height / 5, // 157
                child: ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    height: screenSize.height / 3, // 157
                    color: const Color(0xffCCE5FF),
                    child: Center(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(' La Revancha',
                                style: TextStyle(
                                    fontSize: screenSize.width * 0.05,
                                    color: Colors.white)),
                            subtitle: Text('C. 86 Santa Cruz Palomeque, Yuc.',
                                style: TextStyle(
                                    fontSize: screenSize.width * 0.03,
                                    color: Colors.grey)),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin:
                                EdgeInsets.only(right: screenSize.width * 0.32),
                            width: screenSize.width * 0.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xF0334155)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Rancho',
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.04,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
