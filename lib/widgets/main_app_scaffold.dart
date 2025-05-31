import 'package:flutter/material.dart';
import 'package:sportsapp/widgets/app_drawer.dart';

class MainAppScaffold extends StatelessWidget {
  final Widget child;
  final bool showDrawer;
  final bool
  showBackButton; // New parameter to control the back button visibility

  const MainAppScaffold({
    super.key,
    required this.child,
    this.showDrawer = true,
    this.showBackButton = false, 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 54, 172, 25),
        leading:
            showBackButton
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
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
