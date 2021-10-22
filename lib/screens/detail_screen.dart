import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/restaurant.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/widgets/custom_loading.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';

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
              _CarouselImages(place.imgURLs),
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
              else if (place is Restaurant)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text('메뉴 보기'),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                _MenuDialog(menu: place.menu));
                      },
                    ),
                    ElevatedButton(
                      child: Text('영업시간 보기'),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                _TimeDialog(time: place.time));
                      },
                    ),
                  ],
                )
            ],
          ),
        ));
  }
}

class _CarouselImages extends StatelessWidget {
  final List<dynamic> downloadedURL;
  _CarouselImages(this.downloadedURL);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height * 0.35,
        child: Carousel(
          dotSize: 7,
          images: [
            for (var image in downloadedURL) Image.network(image),
          ],
        ));
  }
}

class _TimeDialog extends StatelessWidget {
  final String time;
  _TimeDialog({required this.time});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Text(
        time,
      ),
    );
  }
}

class _MenuDialog extends StatelessWidget {
  final String menu;
  _MenuDialog({required this.menu});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Text(
        menu,
      ),
    );
  }
}
