import 'package:flutter/material.dart';
import 'package:sportsapp/services/auth_service.dart';
import 'package:sportsapp/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}


class _LoginState extends State<LoginScreen> {
  //* Instance of AuthService to handle authentication
  final AuthService _authService = AuthService();

  Future<void> _handleGoogleSignIn() async {
    final user = await _authService.signInWithGoogle();
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _handleGoogleSignIn,
          icon: Image.asset(
            'assets/images/google_logo.png',
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
