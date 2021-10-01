import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/repositories/tourist_attraction_repository.dart';

class SelectProvider with ChangeNotifier {
  final repository = TouristAttractionRepository();
  List<TouristAttraction> touristAttractions = [];
  final randomURL = [];
  final randomImg = [];
  bool isLoading = false;

  SelectProvider() {
    fetch(10);
  }

  fetch(int count) async {
    isLoading = true;
    notifyListeners();
    var filter = new List<int>.generate(600, (i) => i + 1);
    print(filter);
    touristAttractions = await repository.getData(filter);
    print(touristAttractions.length);
    for (int i = 0; i < count; i++) {
      int rand = Random().nextInt(touristAttractions.length);
      await downloadImage(rand);
    }
    isLoading = false;
    notifyListeners();
  }

  // Storage에서 이미지 다운로드
  Future<void> downloadImage(int rand) async {
    int rand2 = Random().nextInt(touristAttractions[rand].imgUrl!.length);
    randomImg.add(touristAttractions[rand].imgUrl![rand2]);
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('tourist_attraction')
        .child(touristAttractions[rand].imgUrl![rand2] + '.jpg');
    String url = await ref.getDownloadURL();
    randomURL.add(url);
  }
}
