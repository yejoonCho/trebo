import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/provider/weather_provider.dart';
import 'package:trebo/repositories/tourist_attraction_repository.dart';
import 'package:trebo/screens/category_screen.dart';
import 'package:trebo/screens/list/list_screen.dart';
import 'package:trebo/screens/select/select_screen.dart';
import 'package:trebo/screens/list/list_screen_app_bar.dart';
import 'package:trebo/widgets/bottom_navigation_bar.dart';
import 'package:trebo/widgets/drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final touristAttractions = Provider.of<List<TouristAttraction>>(context);
    return Scaffold(
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: weatherProvider.isLoading
          ? _loadingWidget()
          : Container(
              alignment: Alignment.center,
              color: Colors.grey.shade300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Profile', style: TextStyle(fontSize: 24)),
                  SizedBox(height: 32),
                  CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(user.photoURL!)),
                  SizedBox(height: 8),
                  Text(
                    'Name: ' + user.displayName!,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Email: ' + user.email!,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  ElevatedButton(
                    child: Text('to the Category Screen'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryScreen()));
                    },
                  ),
                  ElevatedButton(
                    child: Text('test'),
                    onPressed: () {
                      print(touristAttractions.length);
                    },
                  )
                ],
              ),
            ),
    );
  }

  Widget _loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator(), Text('정보를 가져오는 중')],
      ),
    );
  }
}
