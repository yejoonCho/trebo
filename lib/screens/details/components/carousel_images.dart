import 'package:flutter/material.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';

class CarouselImages extends StatelessWidget {
  final List<dynamic> imagesUrl;
  CarouselImages(this.imagesUrl);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height * 0.35,
        child: Carousel(
          dotSize: 7,
          images: [
            for (var image in imagesUrl) Image.network(image),
          ],
        ));
  }
}
