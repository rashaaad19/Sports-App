import 'package:flutter/material.dart';
import 'package:sportsapp/screens/countries_screen.dart';
import 'package:sportsapp/services/auth_service.dart';
import 'package:sportsapp/widgets/dialog_helpers.dart';
import 'package:sportsapp/widgets/main_app_scaffold.dart';
import 'package:sportsapp/widgets/sports_card.dart';

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
      title: 'Home',
      showDrawer: true,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          final itemWidth = screenWidth / 2;
          final itemHeight = screenHeight / 2;

          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: itemWidth / itemHeight,
            children: [
              buildSportCard(
                title: 'Football',
                iconPath: 'assets/images/football-icon.svg',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CountriesScreen()),
                  );
                },
              ),
              buildSportCard(
                title: 'Basketball',
                iconPath: 'assets/images/basketball-icon.svg',
                onTap:
                    () => showDialog(
                      context: context,
                      builder: (context) => ComingSoonDialog(),
                    ),
              ),
              buildSportCard(
                title: 'Bowling',
                iconPath: 'assets/images/bowling-icon.svg',
                onTap:
                    () => showDialog(
                      context: context,
                      builder: (context) => ComingSoonDialog(),
                    ),
              ),
              buildSportCard(
                title: 'Tennis',
                iconPath: 'assets/images/tennis-icon.svg',
                onTap:
                    () => showDialog(
                      context: context,
                      builder: (context) => ComingSoonDialog(),
                    ),
              ),
            ],
          );
        },
      ),
    );
  }
}
