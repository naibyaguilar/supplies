import 'package:flutter/material.dart';
import 'package:supplies/src/models/activity_model.dart';
import 'package:supplies/src/widgets/widgets.dart';

import '../service/service.dart';

class ListHome extends StatelessWidget {
  const ListHome({
    Key? key,
    required this.activities,
  }) : super(key: key);

  final List<Activities?> activities;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: activities.length,
        itemBuilder: (BuildContext context, int index) => TaskCard(
              activity: activities[index]!,
            ));
  }
}
