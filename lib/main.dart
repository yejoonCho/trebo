import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/provider/google_sign_in.dart';
import 'package:trebo/provider/select_provider.dart';
import 'package:trebo/provider/list_provider.dart';
import 'package:trebo/provider/weather_provider.dart';
import 'package:trebo/screens/login_screen.dart';
import 'package:trebo/screens/recommend_screen.dart';

void main() async {
  // 파이어베이스 설정
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
      ChangeNotifierProvider(create: (context) => WeatherProvider()),
      ChangeNotifierProvider(create: (context) => ListProvider()),
      ChangeNotifierProvider(create: (context) => SelectProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TREBO',
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
