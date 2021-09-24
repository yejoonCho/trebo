import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/repositories/tourist_attraction_repository.dart';

class TouristAttractionProvider with ChangeNotifier {
  List<TouristAttraction> touristAttractions = [];
  bool isLoading = false;
  final _touristAttractionRepository = TouristAttractionRepository();

  TouristAttractionProvider() {
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();

    touristAttractions = await _touristAttractionRepository.fetch();
    isLoading = false;
    notifyListeners();
  }

  downloadImage(int index) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(touristAttractions[index].imgUrl![0]);
    String url = await ref.getDownloadURL();
    touristAttractions[index].imgUrl![0] = url;
  }
}
