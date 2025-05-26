import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print("UID: ${user.uid}");
      print("Email: ${user.email}");
      print("Display Name: ${user.displayName}");
      print("Photo URL: ${user.photoURL}");
    } else {
      print("No user is currently signed in.");
    }

    return Scaffold(body: Center(child: Text('Home Screeen')));
  }
}
