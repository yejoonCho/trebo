import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/provider/tourist_attraction_provider.dart';
import 'package:trebo/screens/tourist_attraction_screen.dart';
import 'package:trebo/widgets/app_bar.dart';
import 'package:trebo/widgets/categories.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(),
          Categories(),
          TouristAttractionScreen(),
        ],
      ),
    );
  }
}
