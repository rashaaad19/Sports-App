import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sportsapp/cubit/leagues_cubit.dart';
import 'package:sportsapp/cubit/squad_cubit.dart';
import 'package:sportsapp/cubit/teams_cubit.dart';
import 'package:sportsapp/cubit/topScorers_cubit.dart';
import 'package:sportsapp/repos/leagues_repo.dart';
import 'package:sportsapp/repos/squad_repo.dart';
import 'package:sportsapp/repos/teams_repo.dart';
import 'package:sportsapp/repos/topScorers_repo.dart';
import 'package:sportsapp/screens/home_screen.dart';

import 'firebase_options.dart';
import 'package:sportsapp/cubit/countries_cubit.dart';
import 'package:sportsapp/repos/countries_repo.dart';
import 'package:sportsapp/screens/login_screen.dart';
import 'package:sportsapp/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();
  final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  final User? user = FirebaseAuth.instance.currentUser;

  runApp(MyApp(isFirstTime: isFirstTime,user:user));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  final User? user;
  const MyApp({super.key, required this.isFirstTime, required this.user});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CountriesCubit(CountryRepo())),
        BlocProvider(create: (_) => LeaguesCubit(LeaguesRepo())),
        BlocProvider(create: (_) => TeamsCubit(TeamsRepo())),
        BlocProvider(create: (_) => TopscorersCubit(TopscorersRepo())),
        BlocProvider(create: (_) => SquadCubit(PlayersRepo())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                elevation: 0,
                scrolledUnderElevation: 0,
                color: Colors.white,
              ),
              colorScheme: const ColorScheme.light(
                surface: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            title: 'Sports App',
            home:
                isFirstTime
                    ? const OnboardingScreen()
                    : user == null
                    ? const LoginScreen()
                    : const HomeScreen(),
          );
        },
      ),
    );
  }
}
