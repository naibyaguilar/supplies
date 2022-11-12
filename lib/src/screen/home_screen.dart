import 'package:flutter/material.dart';
import 'package:supplies/src/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    int _selectedPageIndex = 0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: const AppBarHome(),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: screenSize.height * 0.25,
            width: screenSize.width,
            child: Image.asset(
              'assets/images/wave.png',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenSize.height * 0.11),
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) =>
                    const TaskCard()),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: const Color(0xEF007CFF),
          unselectedItemColor: const Color(0xFF115DA9),
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'home'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.assignment_rounded), label: 'home'),
            BottomNavigationBarItem(
                icon: FloatingActionButton(
                  backgroundColor: const Color(0xFF115DA9),
                  onPressed: () {},
                  tooltip: 'Increment',
                  elevation: 4.0,
                  child: const Icon(
                    Icons.add_circle_outline_outlined,
                    size: 50,
                  ),
                ),
                label: 'home'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.group_rounded), label: 'home'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'home'),
          ]),
    );
  }
}
