import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplies/src/models/farm_model.dart';
import 'package:supplies/src/widgets/farm_card.dart';

import '../../service/service.dart';
import '../screens.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return SizedBox(
      width: screenSize.width,
      height: screenSize.height * 0.80,
      child: FutureBuilder(
          future: Provider.of<FarmService>(context).LoadFarm(),
          builder: (BuildContext context, AsyncSnapshot<List<Farm?>> snapshot) {
            if (!snapshot.hasData) return const LoadingScreen();
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) => FarmCard(
                      farm: snapshot.data![index]!,
                    ));
          }),
    );
  }
}
