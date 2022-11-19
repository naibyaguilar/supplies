import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

// import 'package:provider/provider.dart';
// import '../models/models.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // final _person = Provider.of<Person>(context);
    var screenSize = MediaQuery.of(context).size;
    final _selectedPageIndex = <int>[2, 1];
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
              child: Stack(
                children: [
                  ClipPath(
                    clipper: CustomShape(),
                    child: Container(
                      height: screenSize.height / 3, // 157
                      color: const Color(0xffCCE5FF),
                      child: Center(
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: CircleAvatar(
                                radius: 45,
                                backgroundImage: AssetImage(
                                    "assets/images/profile_default.png"),
                              ),
                            ),
                            Text(
                              '_person.name',
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.05,
                                  color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _getActionMenu('Correo electrónico', '_person.email', Icons.email,
                () {}, screenSize.width),
            _getActionMenu('Número de celular', '_person.phone', Icons.phone,
                () {}, screenSize.width),
            _getActionMenu('Fecha de nacimiento', '_person.birthday',
                Icons.calendar_month_rounded, () {}, screenSize.width),
            _getActionMenu('Dirección', '_person.address', Icons.home_filled,
                () {}, screenSize.width),
            _getActionMenu('Contraseña', '_person.password', Icons.password,
                () {}, screenSize.width),
            ListTile(
              title: Text(
                'Administrando',
                style: TextStyle(fontSize: screenSize.width * 0.05),
              ),
            ),
            SizedBox(
              width: screenSize.width,
              height: screenSize.height * 0.25,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: (_selectedPageIndex.isEmpty)
                    ? _selectedPageIndex.length + 1
                    : _selectedPageIndex.length,
                itemBuilder: (BuildContext context, int index) =>
                    (index == _selectedPageIndex.length - 1)
                        ? _setAddFarm(screenSize)
                        : _getFarms(screenSize, context),
              ),
            ),
            ElevatedButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'login'),
                // ignore: todo
                // * TODO: Log Out
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: const Text('Cerrar Sesión'))
          ],
        ),
      ),
    );
  }
}

Card _getFarms(Size screenSize, BuildContext context) {
  return Card(
    elevation: 25,
    child: SizedBox(
      width: screenSize.width * 0.60,
      height: screenSize.height * 0.23,
      child: InkWell(
        child: Container(
          color: const Color(0xEF115DA9),
          child: Column(
            children: [
              Image.asset(
                'assets/images/farmer_amico.png',
                height: screenSize.height * 0.07,
                width: screenSize.width * 0.60,
                fit: BoxFit.fitWidth,
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(right: screenSize.width * 0.32),
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
              ListTile(
                title: Text(' La Revancha',
                    style: TextStyle(
                        fontSize: screenSize.width * 0.05,
                        color: Colors.white)),
                subtitle: Text('C. 86 Santa Cruz Palomeque, Yuc.',
                    style: TextStyle(
                        fontSize: screenSize.width * 0.03, color: Colors.grey)),
              )
            ],
          ),
        ),
        onTap: () => Navigator.pushReplacementNamed(context, 'farm_admin'),
      ),
    ),
  );
}

Card _setAddFarm(Size screenSize) {
  return Card(
    elevation: 25,
    child: SizedBox(
      width: screenSize.width * 0.3,
      height: screenSize.height * 0.23,
      child: InkWell(
        child: const Icon(
          Icons.add_circle,
          size: 40,
          color: Colors.amber,
        ),
        onTap: () {},
      ),
    ),
  );
}

ListTile _getActionMenu(
    String title, String sub, IconData icon, Function() onTap, double width) {
  return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      // leading: Icon(icon, size: width * 0.05),
      title: Text(title, style: TextStyle(fontSize: width * 0.04)),
      subtitle: Text(sub, style: TextStyle(fontSize: width * 0.04)),
      // onTap: onTap,
      minLeadingWidth: 10,
      minVerticalPadding: 01);
}
