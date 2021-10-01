import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/repositories/tourist_attraction_repository.dart';

class RandomImageProvider with ChangeNotifier {
  final _touristAttractionRepository = TouristAttractionRepository();
  List<TouristAttraction> touristAttractions = [];
  final randomURL = [];
  final randomImg = [];
  bool isLoading = false;

  RandomImageProvider() {
    fetch(10);
  }

  fetch(int count) async {
    isLoading = true;
    notifyListeners();

    touristAttractions = await _touristAttractionRepository.getData();
    // 원하는 갯수만큼 랜덤 이미지 생성
    for (int i = 0; i < count; i++) {
      int rand = Random().nextInt(touristAttractions.length);
      await downloadImage(rand);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> downloadImage(int rand) async {
    int rand2 = Random().nextInt(touristAttractions[rand].imgURL!.length);
    randomImg.add(touristAttractions[rand].imgURL![rand2].keys.toList()[0]);

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('tourist_attraction')
        .child(touristAttractions[rand].imgURL![rand2].keys.toList()[0]);
    String url = await ref.getDownloadURL();
    randomURL.add(url);
  }
}
