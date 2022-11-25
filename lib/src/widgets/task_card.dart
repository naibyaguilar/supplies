import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';

class TaskCard extends StatelessWidget {
  final Activities activity;

  const TaskCard({Key? key, required this.activity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () => Navigator.pushReplacementNamed(context, 'assingId'),
        child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 30),
            width: double.infinity,
            height: 180,
            decoration: _cardBorders(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    activity.name,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8, right: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color(0x4B000000)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      activity.description,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.white,
                      ),
                      Text(
                        'Hacer el: ${DateFormat.yMMMMEEEEd().format(activity.executionDate)}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.sell,
                        color: Colors.white,
                      ),
                      Text(
                        'Tipo: ${activity.sType()}',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
          color: const Color(0XffB2E9A4),
          borderRadius: BorderRadius.circular(25),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            const BoxShadow(
                color: Colors.grey, offset: Offset(0, 7), blurRadius: 10)
          ]);
}
