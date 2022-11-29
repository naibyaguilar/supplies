import 'package:flutter/material.dart';
import 'package:supplies/src/widgets/widgets.dart';

import '../service/service.dart';

class ListHome extends StatelessWidget {
  const ListHome({
    Key? key,
    required this.activityService,
  }) : super(key: key);

  final ActivitiesService activityService;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: activityService.activities.length,
        itemBuilder: (BuildContext context, int index) => TaskCard(
              activity: activityService.activities[index],
            ));
  }
}
