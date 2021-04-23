import 'dart:io';

import 'package:retrash_app/data/requests/request.dart';

class AuthRequest extends Request {
  late String name;
  late String surname;
  late String email;
  late String phoneNumber;
  late String password;
  late int points;
  File? profilePhoto;

  AuthRequest.empty() {
    name = '';
    surname = '';
    email = '';
    phoneNumber = '';
    password = '';
    points = 0;
  }

  @override
  bool isEmpty() {
    return name.trim().isEmpty ||
        surname.trim().isEmpty ||
        email.trim().isEmpty ||
        phoneNumber.trim().isEmpty ||
        password.trim().isEmpty;
  }
}
