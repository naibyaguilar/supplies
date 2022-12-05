import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplies/src/models/models.dart';

import '../../service/service.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class FarmAdminScreen extends StatelessWidget {
  const FarmAdminScreen({super.key, required this.farm});
  final Farm farm;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBarFarm(context, screenSize, farm),
      body: Column(
        children: [
          Text(
            'Miembros',
            style: TextStyle(
                fontSize: screenSize.width * 0.05, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: screenSize.width,
            height: screenSize.height * 0.25,
            child: FutureBuilder(
                future:
                    Provider.of<ProfileService>(context).GetMember(farm.id!),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Person?>> snapshot) {
                  if (!snapshot.hasData) return const LoadingScreen();
                  return ListView.builder(
                    itemCount: 3,
                    itemBuilder: ((context, index) => Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(
                                    "assets/images/profile_default.png"),
                              ),
                            ),
                            Text(
                              (snapshot.data![index]!.name).toString(),
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.05,
                                  color: Colors.grey[800]),
                            ),
                          ],
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }

  PreferredSize _appBarFarm(BuildContext context, Size screenSize, Farm farm) {
    return PreferredSize(
      preferredSize: Size.fromHeight(screenSize.height / 5),
      child: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: const Color(0xffffffff),
        flexibleSpace: ClipPath(
          clipper: CustomShape(),
          child: Container(
              height: screenSize.height / 3, // 157
              color: const Color(0xEF115DA9),
              child: Padding(
                padding: EdgeInsets.only(top: screenSize.height / 15),
                child: Center(
                  widthFactor: screenSize.width,
                  child: Column(
                    children: [
                      ListTile(
                        trailing: InkWell(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            final farmService = Provider.of<FarmService>(
                                context,
                                listen: false);
                            await farmService.daleteFarm(farm);

                            Navigator.pushReplacementNamed(context, 'home');
                          },
                          child: const Icon(
                            Icons.delete_forever_rounded,
                            color: Colors.redAccent,
                          ),
                        ),
                        title: Text(farm.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: screenSize.width * 0.05,
                                color: Colors.white)),
                        subtitle: Text(farm.address,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: screenSize.width * 0.03,
                                color:
                                    const Color.fromARGB(238, 158, 186, 224))),
                      ),
                      Container(
                        width: screenSize.width * 0.30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(239, 111, 134, 167)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            farm.type,
                            textAlign: TextAlign.center,
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
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
