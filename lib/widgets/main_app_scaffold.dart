import 'package:flutter/material.dart';
import 'package:sportsapp/widgets/app_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainAppScaffold extends StatelessWidget {
  final Widget child;
  final bool showDrawer;
  final bool showBackButton;
  final String title;

  const MainAppScaffold({
    super.key,
    required this.title,
    required this.child,
    this.showDrawer = true,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp, // Responsive size using ScreenUtil
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 54, 172, 25),
        leading:
            showBackButton
                ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
                : Container(),
      ),
      drawer: showDrawer ? const AppDrawer() : null,
      body: SafeArea(child: child),
    );
  }
}
