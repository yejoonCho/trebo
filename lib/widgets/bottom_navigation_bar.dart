import 'package:flutter/material.dart';
import 'package:trebo/screens/home_screen.dart';
import 'package:trebo/screens/recommend_screen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
            break;
          case 1:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RecommendScreen()));
            break;
        }
      },
      selectedItemColor: Colors.amber[800],
      currentIndex: 0,
      items: [
        _bottomNavigationBarItem('Home', Icons.home),
        _bottomNavigationBarItem('Recommend', Icons.recommend),
        _bottomNavigationBarItem('Map', Icons.pin_drop_outlined)
      ],
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String title, IconData iconName) {
    return BottomNavigationBarItem(
      icon: Icon(
        iconName,
        size: 35,
      ),
      label: title,
    );
  }
}
