import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportsapp/services/auth_service.dart';
import 'package:sportsapp/widgets/dialog_helpers.dart';
import 'package:sportsapp/widgets/main_app_scaffold.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                onTap: () => print('Football tapped'),
              ),
              buildSportCard(
                title: 'Basketball',
                iconPath: 'assets/images/basketball-icon.svg',
                onTap: () => showComingSoonDialog(context),
              ),
              buildSportCard(
                title: 'Bowling',
                iconPath: 'assets/images/bowling-icon.svg',
                onTap: () => showComingSoonDialog(context),
              ),
              buildSportCard(
                title: 'Tennis',
                iconPath: 'assets/images/tennis-icon.svg',
                onTap: () => showComingSoonDialog(context),

              ),
            ],
          );
        },
      ),
    );
  }
}
