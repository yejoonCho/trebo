import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/provider/similar_list_provider.dart';
import 'package:trebo/screens/detail/detail_app_bar.dart';
import 'package:trebo/widgets/custom_loading.dart';

import 'carousel_images.dart';

class DetailScreen extends StatelessWidget {
  final TouristAttraction? touristAttraction;

  DetailScreen({@required this.touristAttraction});

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CarouselImages(touristAttraction!.imgURLs),
              SizedBox(height: 10),
              Text(
                touristAttraction!.title,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                touristAttraction!.address,
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  touristAttraction!.description,
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ));
  }
}
