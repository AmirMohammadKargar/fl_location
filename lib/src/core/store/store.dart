import 'package:firebase_auth/firebase_auth.dart';

class Store {
  static User? user;
  static String? token;

  static void logout() {
    user = null;
    token = null;
  }
}
