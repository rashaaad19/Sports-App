import 'package:flutter/material.dart';
import 'package:sportsapp/services/auth_service.dart';
import 'package:sportsapp/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    //* Create an instance of AuthService to handle sign out
    final authService = AuthService();
    await authService.signOut();
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final user = authService.auth.currentUser;

    if (user != null) {
      debugPrint("User Data:"); // Better than print for Flutter
      debugPrint("UID: ${user.uid}");
      debugPrint("Email: ${user.email}");
      debugPrint("Display Name: ${user.displayName}");
      debugPrint("Photo URL: ${user.photoURL}");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user?.photoURL != null)
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL!),
                radius: 40,
              ),
            const SizedBox(height: 20),
            Text('Welcome ${user?.displayName ?? 'User'}'),
            Text(user?.email ?? ''),
          ],
        ),
      ),
    );
  }
}
