import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/provider/similar_list_provider.dart';
import 'package:trebo/screens/details/components/detail_app_bar.dart';
import 'package:trebo/widgets/custom_loading.dart';

import 'components/carousel_images.dart';

class DetailScreen extends StatelessWidget {
  final TouristAttraction? touristAttraction;

  DetailScreen({@required this.touristAttraction});

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: top),
        CarouselImages(touristAttraction!.downloadedURL!),
      ],
    ));
  }
}
