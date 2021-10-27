import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/notifiers/like_notifier.dart';
import 'package:trebo/widgets/like_button.dart';

class DetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final dynamic place;
  final double screenWidth;
  final double screenHeight;
  final double paddingTop;

  DetailAppBar(
      {required this.place,
      required this.screenWidth,
      required this.screenHeight,
      required this.paddingTop});

  @override
  Size get preferredSize => Size.fromHeight(screenHeight * 0.25);

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
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    place.title,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              _BackArrowButton(),
              Positioned(
                right: 15,
                child: ChangeNotifierProvider.value(
                  value: LikeNotifier(place: place),
                  child: LikeButton(),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          Container(
            height: screenHeight * 0.04,
            child: Align(
              child: Text(
                place.address,
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Container(
            height: screenHeight * 0.07,
            child: _TabBar(),
          ),
        ],
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: [
        Tab(
          child: Text(
            '정보',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        Tab(
          child: Text(
            '지도',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class _BackArrowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 15,
      child: ClayContainer(
        height: 50,
        width: 50,
        depth: 20,
        borderRadius: 25,
        curveType: CurveType.concave,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey.shade300, width: 2),
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
    );
  }
}
