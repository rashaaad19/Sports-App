import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportsapp/services/auth_service.dart';
import 'package:sportsapp/screens/login_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
  Future<void> _logout(BuildContext context) async {
    final authService = AuthService();
    await authService.signOut();
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Padding(
              padding: EdgeInsets.only(top: 12.h), 
              child: Text(
                user?.displayName ?? 'No Name',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            accountEmail: Text(
              user?.email ?? 'No Email',
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white70,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              radius: 34.r,
              backgroundColor: Colors.white,
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : null,
              child: user?.photoURL == null
                  ? Icon(Icons.person, size: 40.sp, color: Colors.grey.shade700)
                  : null,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF36AC19), Color(0xFF2C8D14)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              children: [
                ListTile(
                  leading: Icon(Icons.logout, size: 24.sp, color: Colors.redAccent),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.redAccent,
                    ),
                  ),
                  onTap: () {
                   _logout(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
