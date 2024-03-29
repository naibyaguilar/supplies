import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplies/src/screen/screens.dart';
import 'package:supplies/src/widgets/widgets.dart';

import '../../providers/providers.dart';
import '../../service/service.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _appBarHome(screenSize, context),
        body: _Paginas(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }

  PreferredSize _appBarHome(Size screenSize, BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(screenSize.height / 6),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.5),
          flexibleSpace: ClipPath(
            clipper: CustomPaintPages(),
            child: Container(
              height: screenSize.height / 2, // 157
              color: const Color(0xEF115DA9).withOpacity(0.2),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onDoubleTap: () {
                        Navigator.pushNamed(context, 'profile');
                        // setState(() {});
                      },
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
                      'Buenas tardes',
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
            ),
          ),
        ));
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);
    final activitieService = Provider.of<ActivitiesService>(context);

    return BottomNavigationBar(
        currentIndex: navigationModel.currentPage,
        onTap: (i) => navigationModel.currentPage = i,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.assignment_rounded), label: 'assignment list'),
          BottomNavigationBarItem(
              icon: FloatingActionButton(
                backgroundColor: const Color(0xFF115DA9),
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Opciones a agregar'),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          value: navigationModel.dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Color(0xEF007CFF)),
                          underline: Container(
                            height: 2,
                            color: const Color(0xEF007CFF),
                          ),
                          onChanged: (String? value) {
                            navigationModel.dropdownValue = value!;
                            Navigator.of(context, rootNavigator: true)
                                .pop(true);
                          },
                          items: activitieService.listtype
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop(false);
                          },
                          child: const Text('Cancelar'),
                        ),
                      ],
                    ),
                  );
                },
                tooltip: 'Agregar',
                elevation: 4.0,
                child: const Icon(
                  Icons.add_circle_outline_outlined,
                  size: 50,
                ),
              ),
              label: 'Add assignment'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.group_rounded), label: 'farm groups'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'settings'),
        ],
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: const Color(0xEF007CFF),
        unselectedItemColor: const Color(0xFF115DA9));
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        const HomeScreen(),
        const ListScreen(),
        CreationScreen(
          initialForm: navigationModel._dropdownValue,
        ),
        const GroupsScreen(),
        const SettingsScreens()
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;

    _pageController.animateToPage(value,
        duration: const Duration(milliseconds: 250),
        curve: Curves.linearToEaseOut);

    notifyListeners();
  }

  String _dropdownValue = 'Actividad';
  String get dropdownValue => _dropdownValue;

  set dropdownValue(String value) {
    _dropdownValue = value;
    currentPage = 2;
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
