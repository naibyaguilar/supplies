import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplies/src/models/activity_model.dart';

import '../../service/service.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: screenSize.height * 0.22),
      child: Column(
        children: [
          const Text(
            'Mis Actividades:',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            width: screenSize.width,
            height: screenSize.height * 0.25,
            child: FutureBuilder(
                future:
                    Provider.of<ActivitiesService>(context).LoadMyActivities(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Activities?>> snapshot) {
                  if (!snapshot.hasData) return const LoadingScreen();
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) =>
                          TaskCard(
                            activity: snapshot.data![index]!,
                          ));
                }),
          ),
          const Divider(),
          const Text(
            'Las Actividades de mis Ranchos:',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            width: screenSize.width,
            height: screenSize.height * 0.25,
            child: FutureBuilder(
                future: Provider.of<ActivitiesService>(context)
                    .LoadActivitiesbyFarmAdmin(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Activities?>> snapshot) {
                  if (!snapshot.hasData) return const LoadingScreen();
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) =>
                          TaskCard(
                            activity: snapshot.data![index]!,
                          ));
                }),
          ),
        ],
      ),
    );
  }
}
