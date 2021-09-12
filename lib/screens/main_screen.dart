import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trebo/screens/home_screen.dart';
import 'package:trebo/screens/login_screen.dart';
import 'package:trebo/widgets/app_bar.dart';
import 'package:trebo/widgets/bottom_navigation_bar.dart';
import 'package:trebo/widgets/drawer.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return HomeScreen();
        } else if (snapshot.hasError) {
          return Center(child: Text('Something Went Wrong!'));
        } else {
          return LoginScreen();
        }
      },
    ));
  }
}
