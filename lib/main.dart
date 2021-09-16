import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/provider/google_sign_in.dart';
import 'package:trebo/provider/weather_provider.dart';
import 'package:trebo/screens/home_screen.dart';
import 'package:trebo/screens/login_screen.dart';
import 'package:trebo/screens/recommend_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
      ChangeNotifierProvider(create: (context) => WeatherProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TREBO',
      initialRoute: '/login',
      routes: {
        '/home': (context) => HomeScreen(),
        '/recommend': (context) => RecommendScreen(),
        '/login': (context) => LoginScreen()
      },
    );
  }
}
