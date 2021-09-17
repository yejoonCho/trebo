import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/provider/tourist_attraction_provider.dart';
import 'package:trebo/widgets/app_bar.dart';
import 'package:trebo/widgets/categories.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(),
          Categories(),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('touristAttraction')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                return _buildContents(snapshot.data!);
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildContents(QuerySnapshot snapshot) {
    return Expanded(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            final docs = snapshot.docs[index];
            final touristAttraction = TouristAttraction.fromSnapshot(docs);
            final ref =
                FirebaseStorage.instance.ref().child(touristAttraction.imgUrl!);
            var url = ref.getDownloadURL();
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                  height: 250,
                  child: Column(
                    children: [
                      Text(touristAttraction.title!),
                      Text(touristAttraction.address!)
                    ],
                  )),
            );
          }),
    );
  }
}
