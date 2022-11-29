import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplies/src/models/models.dart';

import '../../service/service.dart';
import '../../widgets/widgets.dart';

class FarmAdminScreen extends StatelessWidget {
  const FarmAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    Future<List<Person>> members =
        Provider.of<ProfileService>(context).GetMember(1);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: const Color(0xffffffff),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(screenSize.height / 5),
            child: Container()),
        flexibleSpace: ClipPath(
          clipper: CustomShape(),
          child: Container(
              height: screenSize.height / 3, // 157
              color: const Color(0xEF115DA9),
              child: Padding(
                padding: EdgeInsets.only(
                    top: screenSize.height / 10, left: screenSize.width / 9),
                child: Center(
                  widthFactor: screenSize.width,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(' La Revancha',
                            style: TextStyle(
                                fontSize: screenSize.width * 0.05,
                                color: Colors.white)),
                        subtitle: Text('C. 86 Santa Cruz Palomeque, Yuc.',
                            style: TextStyle(
                                fontSize: screenSize.width * 0.03,
                                color: Colors.grey)),
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
                    ],
                  ),
                ),
              )),
        ),
      ),
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
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: ((context, index) => Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage("assets/images/profile_default.png"),
                        ),
                      ),
                      Text(
                        (true) //'personService.person.isNotEmpty'
                            ? 'FarmService.person[0].name'
                            : '',
                        style: TextStyle(
                            fontSize: screenSize.width * 0.05,
                            color: Colors.grey[800]),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
