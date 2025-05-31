import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportsapp/screens/home_screen.dart';
import 'package:sportsapp/screens/login_screen.dart';
import 'package:sportsapp/screens/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  //* ensure that the Flutter engine is initialized before using any plugins or widgets.
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  const MyApp({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          //solve colors interaction issue
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              scrolledUnderElevation: 0,
              color: Colors.white,
            ),
            colorScheme: ColorScheme.light(
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          title: 'Sports App',
          home: child,
        );
      },
      child: isFirstTime ? const OnboardingScreen() : const LoginScreen(),
    );
  }
}
