import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trebo/repositories/liked_place_repository.dart';
import 'package:trebo/screens/streamed_list_screen.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final _likePlaceRepository = LikedPlaceRepository(user: user);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.displayName!),
            accountEmail: Text(user.email!),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL!),
              backgroundColor: Colors.white,
            ),
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
          ),
          SizedBox(height: 10),
          Container(
            height: 50,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: GestureDetector(
                  onTap: () async {
                    var places = await _likePlaceRepository.fetch();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StreamedListScreen(
                                  places: places,
                                )));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.view_stream, size: 32),
                      SizedBox(width: 15),
                      Text('찜 리스트 가기', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
