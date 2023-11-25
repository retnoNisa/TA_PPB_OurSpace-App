import 'package:flutter/material.dart';

class FeedbackProvider extends ChangeNotifier {
  String? validateUser(user) {
    if (user.isEmpty) {
      return "Enter Username First!";
    } else {
      return null;
    }
  }

  String? validateEmail(email) {
    if (email.isEmpty) {
      return "Enter Email First!";
    } else {
      return null;
    }
  }

  String? validateMessage(message) {
    if (message.isEmpty) {
      return "Enter A Message First!";
    } else {
      return null;
    }
  }
}
