import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trebo/models/restaurant.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/provider/weather_provider.dart';
import 'package:trebo/screens/category_screen.dart';
import 'package:trebo/widgets/bottom_navigation_bar.dart';
import 'package:trebo/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:trebo/widgets/login_dialog.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final restaurants = Provider.of<List<Restaurant>>(context, listen: false);
    final isUserLoggedIn = Provider.of<bool>(context);
    return Scaffold(
        drawer: isUserLoggedIn
            ? CustomDrawer()
            : Drawer(
                child: Text('로그인 후 이용 가능합니다'),
              ),
        bottomNavigationBar: CustomBottomNavigationBar(),
        appBar: AppBar(
          actions: [
            isUserLoggedIn
                ? TextButton(
                    child: Text(
                      'LogOut',
                      style: TextStyle(
                          color: Colors.yellow.shade300, fontSize: 20),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                  )
                : TextButton(
                    child: Text(
                      'LogIn',
                      style: TextStyle(
                          color: Colors.yellow.shade300, fontSize: 20),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => LoginDialog(),
                      );
                    },
                  ),
            SizedBox(width: 10),
          ],
        ),
        body: isUserLoggedIn
            ? Container(
                child: Center(
                  child: ElevatedButton(
                    child: Text('Test Database'),
                    onPressed: () {
                      // print(restaurants[0].title);
                      // // 테이터 로딩
                      // List<Restaurant> _restaurants = [];
                      // final String response =
                      //     await rootBundle.loadString('data/restaurant.json');
                      // List jsonResult = jsonDecode(response);
                      // jsonResult.forEach((element) {
                      //   final restaurant = Restaurant.fromJson(
                      //       element as Map<String, dynamic>);
                      //   _restaurants.add(restaurant);
                      // });
                      // print(_restaurants.length);

                      // // 이미지 URL 받아오기
                      // for (int i = 0; i < _restaurants.length; i++) {
                      //   for (int j = 0;
                      //       j < _restaurants[i].imgURL!.length;
                      //       j++) {
                      //     print(_restaurants[i].imgURL![j].keys.toList()[0]);
                      //     Reference ref = FirebaseStorage.instance
                      //         .ref()
                      //         .child('restaurant')
                      //         .child(
                      //             _restaurants[i].imgURL![j].keys.toList()[0]);
                      //     String url = await ref.getDownloadURL();
                      //     List<dynamic> vec =
                      //         _restaurants[i].imgURL![j].values.toList()[0];
                      //     _restaurants[i].downloadedURL!.add(url);
                      //     _restaurants[i].vector!.add(vec);
                      //  }
                      // }

                      // // DB에 저장
                      // for (int i = 0; i < _restaurants.length; i++) {
                      //   Map<String, dynamic> result = _restaurants[i].toJson();
                      //   await FirebaseFirestore.instance
                      //       .collection('restaurants')
                      //       .add(result);
                      // }
                    },
                  ),
                ),
              )
            : Center(
                child: Text('로그인 후 이용 가능한 서비스입니다.'),
              ));
  }
}
