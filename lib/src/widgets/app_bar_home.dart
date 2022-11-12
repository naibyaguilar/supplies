import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    // List _isHovering = [false, false];

    return Container(
      // decoration: BoxDecoration(
      //     image: DecorationImage(
      //   image: AssetImage('assets/images/wave.png'),
      //   fit: BoxFit.fill,
      // )),
      width: screenSize.width,
      height: screenSize.height * 0.15,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onDoubleTap: () {},
              onTap: () {},
              child: const CircleAvatar(
                radius: 35,
                backgroundImage:
                    AssetImage("assets/images/profile_default.png"),
              ),
            ),
          ),
          const Expanded(
            child: Text(
              'Buenas tardes Moisés Urang',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              iconSize: 50,
              icon: const Icon(
                Icons.notifications,
                color: Colors.black54,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
