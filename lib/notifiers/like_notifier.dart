import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:trebo/models/restaurant.dart';
import 'package:trebo/models/tourist_attraction.dart';

class LikeNotifier extends ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;
  late dynamic place;
  bool isLiked = false;

  LikeNotifier({required this.place});

  void init() async {
    String? category;
    List streamedList = [];

    if (place is TouristAttraction) {
      category = 'tourist_attraction';
    } else if (place is Restaurant) {
      category = 'retaurant';
    }

    // 읽어오기
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('feelings')
        .doc(user!.uid)
        .get();
    if (documentSnapshot.data() != null) {
      Map json = documentSnapshot.data() as Map<String, dynamic>;

      if (json[category] != null) {
        streamedList = json[category];
      }
    }
    if (streamedList.contains(place.id)) {
      isLiked = true;
      notifyListeners();
    }
  }

  void toggleLike() async {
    String? category;
    List streamedList = [];

    if (place is TouristAttraction) {
      category = 'tourist_attraction';
    } else if (place is Restaurant) {
      category = 'retaurant';
    }

    // 읽어오기
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('feelings')
        .doc(user!.uid)
        .get();
    if (documentSnapshot.data() != null) {
      Map json = documentSnapshot.data() as Map<String, dynamic>;

      if (json[category] != null) {
        streamedList = json[category];
      }
    }

    if (!isLiked) {
      streamedList.add(place.id);
    } else if (isLiked) {
      streamedList.removeWhere((element) => element == place.id);
    }

    // 수정
    FirebaseFirestore.instance
        .collection('feelings')
        .doc(user!.uid)
        .set({category!: streamedList});

    isLiked = !isLiked;
    notifyListeners();
  }
}
