import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sportsapp/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () async {
            bool isLogged = await login();
            if (isLogged) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }
          },
          icon: Image.asset(
            'assets/images/google_logo.png', // Make sure you have this image in your assets
            height: 24,
            width: 24,
          ),
          label: const Text('Continue with Google'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: const TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}

login() async {
  //* Trigger the authentication flow
  final user = await GoogleSignIn().signIn();
  //* Obtain the auth details from the request
  GoogleSignInAuthentication userAuth = await user!.authentication;
  var credential = GoogleAuthProvider.credential(
    accessToken: userAuth.accessToken,
    idToken: userAuth.idToken,
  );
  //* Create a new credential
  UserCredential userCredential = await FirebaseAuth.instance
      .signInWithCredential(credential);
  if (userCredential.user != null) {
    print("User logged in successfully");
    return true;
  } else {
    print("Login failed");
    return false;
  }
}
