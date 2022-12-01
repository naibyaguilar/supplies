import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../service/service.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final activityService = Provider.of<ActivitiesService>(context);
    if (activityService.isLoading) return const LoadingScreen();
    return ListHome(activityService: activityService);
  }
}
