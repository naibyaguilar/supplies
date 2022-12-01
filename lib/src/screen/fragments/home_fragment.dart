import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supplies/src/models/activity_model.dart';

import '../../service/service.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            Provider.of<ActivitiesService>(context).LoadActivitiesbyFarmAdmin(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Activities?>> snapshot) {
          if (!snapshot.hasData) return const LoadingScreen();
          return ListHome(activities: snapshot.data!);
        });
  }
}
