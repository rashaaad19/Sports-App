import 'package:flutter/material.dart';
import 'package:sportsapp/services/auth_service.dart';
import 'package:sportsapp/widgets/main_app_scaffold.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final user = authService.auth.currentUser;

    if (user != null) {
      debugPrint("User Data:");
      debugPrint("UID: ${user.uid}");
      debugPrint("Email: ${user.email}");
      debugPrint("Display Name: ${user.displayName}");
      debugPrint("Photo URL: ${user.photoURL}");
    }

    return MainAppScaffold(
      showDrawer: true, 
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user?.photoURL != null)
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL!),
                radius: 40,
              ),
            const SizedBox(height: 20),
            Text(
              'Welcome ${user?.displayName ?? 'User'}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              user?.email ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}