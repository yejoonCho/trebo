import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

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
          )
        ],
      ),
    );
  }
}
