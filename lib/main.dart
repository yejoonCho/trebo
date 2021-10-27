import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/restaurant.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/repositories/restaurant_repository.dart';
import 'package:trebo/repositories/tourist_attraction_repository.dart';
import 'package:trebo/screens/category_screen.dart';

void main() async {
  // 파이어베이스 설정
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // 레파지토리
  final _touristAttractionRepository = TouristAttractionRepository();
  final _restaurantRepository = RestaurantRepository();

  return runApp(MultiProvider(
    providers: [
      StreamProvider<bool>(
        create: (context) => FirebaseAuth.instance
            .authStateChanges()
            .map((user) => user != null),
        initialData: false,
      ),
      StreamProvider<List<TouristAttraction>>(
        create: (context) => _touristAttractionRepository.fetch(),
        initialData: [],
      ),
      StreamProvider<List<Restaurant>>(
        create: (context) => _restaurantRepository.fetch(),
        initialData: [],
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TREBO',
      home: CategoryScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
