import 'package:flutter/material.dart';
import 'package:trebo/screens/list/tourist_attraction_screen.dart';
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
