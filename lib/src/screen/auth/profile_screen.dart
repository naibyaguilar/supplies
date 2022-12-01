import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supplies/src/service/service.dart';

import '../../models/models.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final personService = Provider.of<ProfileService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    if (personService.isLoading) return const LoadingScreen();

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: const Color(0xFFFFFFFF),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(screenSize.height / 6),
            child: Container()),
        flexibleSpace: ClipPath(
          clipper: CustomShape(),
          child: Container(
              height: screenSize.height / 3, // 157
              color: const Color(0xffCCE5FF),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: screenSize.height / 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage:
                            AssetImage("assets/images/profile_default.png"),
                      ),
                    ),
                    Text(
                      (personService.person.isNotEmpty)
                          ? personService.person[0].name
                          : '',
                      style: TextStyle(
                          fontSize: screenSize.width * 0.05,
                          color: Colors.grey[800]),
                    ),
                  ],
                ),
              )),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _getActionMenu(
                'Correo electrónico',
                (personService.user.isNotEmpty)
                    ? personService.user[0].email
                    : '',
                Icons.email,
                () {},
                screenSize.width),
            _getActionMenu(
                'Número de celular',
                (personService.person.isNotEmpty)
                    ? personService.person[0].phone
                    : '',
                Icons.phone,
                () {},
                screenSize.width),
            _getActionMenu(
                'Fecha de nacimiento',
                DateFormat('yyyy-MM-dd')
                    .format((personService.person.isNotEmpty)
                        ? personService.person[0].birthday
                        : DateTime.now())
                    .toString(),
                Icons.calendar_month_rounded,
                () {},
                screenSize.width),
            _getActionMenu(
                'Dirección',
                (personService.person.isNotEmpty)
                    ? personService.person[0].address
                    : '',
                Icons.home_filled,
                () {},
                screenSize.width),
            _getActionMenu(
                'Contraseña',
                (personService.user.isNotEmpty)
                    ? personService.user[0].password
                    : '',
                Icons.password,
                () {},
                screenSize.width),
            ListTile(
              title: Text(
                'Administrando',
                style: TextStyle(fontSize: screenSize.width * 0.05),
              ),
            ),
            SizedBox(
              width: screenSize.width,
              height: screenSize.height * 0.25,
              child: FutureBuilder(
                  future: personService.getMyFarm(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Farm?>> snapshot) {
                    if (!snapshot.hasData) return const Text('');

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (snapshot.data!.isEmpty)
                          ? 1
                          : snapshot.data!.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index != snapshot.data!.length) {
                          return _getFarms(
                              screenSize, context, snapshot.data![index]!);
                        } else {
                          return _setAddFarm(screenSize, context);
                        }
                      },
                    );
                  }),
            ),
            ElevatedButton(
                onPressed: () => {
                      authService.logout(),
                      Navigator.pushReplacementNamed(context, 'login')
                    },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: const Text('Cerrar Sesión'))
          ],
        ),
      ),
    );
  }
}

Card _getFarms(Size screenSize, BuildContext context, Farm myfarm) {
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
                    myfarm.type,
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
                title: Text(myfarm.name,
                    style: TextStyle(
                        fontSize: screenSize.width * 0.05,
                        color: Colors.white)),
                subtitle: Text(myfarm.address,
                    style: TextStyle(
                        fontSize: screenSize.width * 0.03, color: Colors.grey)),
              )
            ],
          ),
        ),
        onTap: () => Navigator.pushNamed(context, 'farm_admin'),
      ),
    ),
  );
}

Card _setAddFarm(Size screenSize, BuildContext context) {
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
        onTap: () {
          final farmService = Provider.of<FarmService>(context, listen: false);
          // ignore: unnecessary_new
          farmService.selectedfarm = new Farm(
              name: '', area: 0.0, address: '', type: 'type', adminId: 12);
          Navigator.pushNamed(context, 'farm');
        },
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
