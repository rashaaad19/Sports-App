import 'package:flutter/material.dart';
import 'package:sportsapp/widgets/app_drawer.dart';

class MainAppScaffold extends StatelessWidget {
  final Widget child;
  final bool showDrawer;

  const MainAppScaffold({
    super.key,
    required this.child,
    this.showDrawer = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 54, 172, 25)),
      drawer: showDrawer ? const AppDrawer() : null,
      body: SafeArea(child: child),
    );
  }
}
