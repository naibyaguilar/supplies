import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../service/service.dart';
import '../../widgets/widgets.dart';

class AssignScreen extends StatelessWidget {
  final Activities activity;

  const AssignScreen({super.key, required this.activity});
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenSize.height * 0.15),
        child: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: const Color(0xFFFFFFFF),
          flexibleSpace: ClipPath(
            clipper: CustomShape(),
            child: Container(
                height: screenSize.height / 2, // 157
                padding: const EdgeInsets.only(top: 50.0),
                color: const Color(0xEF115DA9),
                child: Center(
                  widthFactor: screenSize.width,
                  child: ListTile(
                    title: Text(' ¡Hey!',
                        style: TextStyle(
                            fontSize: screenSize.width * 0.05,
                            color: Colors.white)),
                    subtitle: Text(
                        '          ¿Tienes esta actividad pendiente?',
                        style: TextStyle(
                            fontSize: screenSize.width * 0.04,
                            color: Colors.grey)),
                  ),
                )),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(activity.nameActivitie,
                  style: TextStyle(
                      fontSize: screenSize.width * 0.09,
                      color: const Color(0xEF115DA9))),
              _getListTitle('Descripcion:', activity.description,
                  Icons.description, screenSize.width),
              _getListTitle('Anotaciones:', activity.note,
                  Icons.note_alt_rounded, screenSize.width),
              _getListTitle(
                  'Afecta a:', activity.type, Icons.password, screenSize.width),
              _getListTitle('Asignado a:', activity.employeeName,
                  Icons.person_pin, screenSize.width),
              _getListTitle('Expira el:', (activity.executionDate).toString(),
                  Icons.calendar_month, screenSize.width),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, 'home'),
                        child: const Text('Entendido',
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          final actiService = Provider.of<ActivitiesService>(
                              context,
                              listen: false);
                          activity.active = 1;
                          await actiService.saveOrCreateActivity(activity);

                          Navigator.pushReplacementNamed(context, 'home');
                        },
                        child: const Text('Listo '),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

ListTile _getListTitle(String title, String? sub, IconData icon, double width) {
  return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      leading: Icon(icon, size: width * 0.05),
      title: Text(title, style: TextStyle(fontSize: width * 0.04)),
      subtitle: Text(sub!, style: TextStyle(fontSize: width * 0.04)),
      // onTap: onTap,
      minLeadingWidth: 10,
      minVerticalPadding: 01);
}
