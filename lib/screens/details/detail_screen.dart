import 'package:flutter/material.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/screens/details/components/detail_app_bar.dart';

import 'components/carousel_images.dart';

class DetailScreen extends StatelessWidget {
  final TouristAttraction? touristAttraction;

  DetailScreen({@required this.touristAttraction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            CarouselImages(touristAttraction!.imgUrl!),
            DetailAppBar(),
          ],
        ),
      ],
    ));
  }
}
