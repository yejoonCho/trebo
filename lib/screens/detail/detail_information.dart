import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:trebo/models/restaurant.dart';
import 'package:trebo/models/tourist_attraction.dart';

class DetailInformation extends StatelessWidget {
  final dynamic place;
  final double screenWidth;
  final double screenHeight;
  DetailInformation(
      {required this.place,
      required this.screenWidth,
      required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
              height: screenHeight * 0.3,
              child: _CarouselImages(place.imgURLs)),
          SizedBox(height: 10),
          if (place is Restaurant)
            Container(
              height: screenHeight * 0.3,
              child: _Informations(place: place, screenWidth: screenWidth),
            )
          else if (place is TouristAttraction)
            Container(
              height: screenHeight * 0.3,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    place.description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _CarouselImages extends StatelessWidget {
  final List<dynamic> downloadedURL;
  _CarouselImages(this.downloadedURL);

  @override
  Widget build(BuildContext context) {
    return Carousel(
      dotSize: 7,
      images: [
        for (var image in downloadedURL) Image.network(image),
      ],
    );
  }
}

class _Informations extends StatefulWidget {
  final dynamic place;
  final double screenWidth;
  _Informations({required this.screenWidth, required this.place});

  @override
  __InformationsState createState() => __InformationsState();
}

class __InformationsState extends State<_Informations> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              child: Text(
                '메뉴',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
            ),
            VerticalDivider(thickness: 2),
            TextButton(
              child: Text(
                '정보',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
            ),
            VerticalDivider(thickness: 2),
            TextButton(
              child: Text(
                '기타',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                setState(() {
                  selectedIndex = 2;
                });
              },
            ),
          ],
        ),
        if (selectedIndex == 0)
          _Content(content: widget.place.menu)
        else if (selectedIndex == 1)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '영업시간',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.place.time,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '전화번호',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.place.phone,
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          )
        else if (selectedIndex == 2)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '태그',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.place.tags.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String content;
  _Content({required this.content});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Container(
          height: 180,
          child: Center(
            child: Text(
              content,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
