import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.grey,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/recommend');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.recommend), label: 'recommend'),
        BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop_outlined), label: 'Map'),
      ],
    );
  }
}
