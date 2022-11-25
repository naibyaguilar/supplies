import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message, BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: const Color(0xEF115DA9),
      content: Text(message,
          style: const TextStyle(color: Colors.white, fontSize: 20)),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    messengerKey.currentState?.showSnackBar(snackBar);
  }
}
