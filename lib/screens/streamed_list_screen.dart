import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:trebo/screens/detail/detail_screen.dart';

class StreamedListScreen extends StatelessWidget {
  final List<dynamic> places;
  StreamedListScreen({required this.places});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingTop = MediaQuery.of(context).padding.top;
    return Scaffold(
        appBar: _AppBar(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            paddingTop: paddingTop),
        body: ListView.builder(
          itemCount: places.length,
          itemBuilder: (context, index) => _ListTile(
            place: places[index],
            screenHeight: screenHeight,
          ),
        ));
  }
}

class _ListTile extends StatelessWidget {
  final dynamic place;
  final double screenHeight;
  _ListTile({required this.place, required this.screenHeight});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      height: screenHeight * 0.15,
      child: Padding(
        padding: EdgeInsets.only(left: 16, top: 4, bottom: 4),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(place: place),
                ));
          },
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                    width: screenHeight * 0.13,
                    height: screenHeight * 0.13,
                    decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.green)),
                    child: Image(
                      image: NetworkImage(place.imgURLs[0]),
                    )),
              ),
              SizedBox(width: 6),
              Padding(
                padding: EdgeInsets.only(left: 6, top: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(place.title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(place.address),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final double screenWidth;
  final double screenHeight;
  final double paddingTop;

  _AppBar(
      {required this.screenWidth,
      required this.screenHeight,
      required this.paddingTop});

  @override
  Size get preferredSize => Size.fromHeight(screenHeight * 0.1);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      child: Column(
        children: [
          SizedBox(height: paddingTop + screenHeight * 0.03),
          Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight * 0.07,
              ),
              Positioned(
                left: 15,
                child: ClayContainer(
                  height: 50,
                  width: 50,
                  depth: 20,
                  borderRadius: 25,
                  curveType: CurveType.concave,
                  child: Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.blueGrey.shade300, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.blueGrey.shade600,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '찜 리스트',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
