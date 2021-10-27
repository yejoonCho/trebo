import 'package:flutter/material.dart';
import 'package:trebo/screens/detail/detail_app_bar.dart';
import 'package:trebo/screens/detail/detail_information.dart';
import 'package:trebo/screens/detail/detail_map.dart';

class DetailScreen extends StatefulWidget {
  late dynamic place;
  DetailScreen({required place}) {
    this.place = place;
  }
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingTop = MediaQuery.of(context).padding.top;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: DetailAppBar(
              place: widget.place,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              paddingTop: paddingTop),
          body: TabBarView(
            children: [
              DetailInformation(
                  place: widget.place,
                  screenWidth: screenWidth,
                  screenHeight: screenHeight),
              DetailMap(
                latitude: widget.place.latitude,
                longitude: widget.place.longitude,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ],
          )),
    );
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
