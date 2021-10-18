import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/screens/detail/detail_app_bar.dart';
import 'package:trebo/widgets/custom_loading.dart';

import 'carousel_images.dart';

class DetailScreen extends StatelessWidget {
  late dynamic place;

  DetailScreen({required place}) {
    this.place = place;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CarouselImages(place.imgURLs),
              SizedBox(height: 10),
              Text(
                place.title,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                place.address,
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 20),
              if (place is TouristAttraction)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    place.description,
                    style: TextStyle(fontSize: 18),
                  ),
                )
            ],
          ),
        ));
  }
}
