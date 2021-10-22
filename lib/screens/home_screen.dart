import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trebo/models/restaurant.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/screens/category_screen.dart';
import 'package:trebo/widgets/bottom_navigation_bar.dart';
import 'package:trebo/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:trebo/widgets/login_dialog.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {},
                  ),
                ),
              )
            : Center(
                child: Text('로그인 후 이용 가능한 서비스입니다.'),
              ));
  }
}
