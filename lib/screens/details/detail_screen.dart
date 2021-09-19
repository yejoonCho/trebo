import 'package:flutter/material.dart';
import 'package:trebo/models/tourist_attraction.dart';

class DetailScreen extends StatelessWidget {
  final TouristAttraction? touristAttraction;

  DetailScreen({@required this.touristAttraction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        MainImage(),
      ],
    ));
  }
}
