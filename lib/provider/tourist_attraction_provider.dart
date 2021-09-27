import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:trebo/models/tourist_attraction.dart';

class TouristAttractionProvider with ChangeNotifier {
  List<TouristAttraction> touristAttractions = [];
  bool isLoading = false;

  TouristAttractionProvider() {
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();

    touristAttractions = await getData();
    await downloadImage();
    isLoading = false;
    notifyListeners();
  }

  // 데이터 DB에서 가져오기
  Future<List<TouristAttraction>> getData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("touristAttraction").get();
    snapshot.docs.forEach((doc) {
      touristAttractions
          .add(TouristAttraction.fromMap(doc.data() as Map<String, dynamic>));
    });
    return touristAttractions
        .where((element) => [1, 2].contains(element.id))
        .toList();
  }

  // Storage에서 이미지 다운로드
  Future<void> downloadImage() async {
    for (int i = 0; i < touristAttractions.length; i++) {
      for (int j = 0; j < touristAttractions[i].imgUrl!.length; j++) {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child(touristAttractions[i].imgUrl![j]);
        String url = await ref.getDownloadURL();
        touristAttractions[i].imgUrl![j] = url;
      }
    }
  }
}
