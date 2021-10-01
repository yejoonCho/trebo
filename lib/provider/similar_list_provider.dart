import 'dart:collection';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/repositories/image_vector_repository.dart';
import 'package:trebo/repositories/location_repository.dart';
import 'package:trebo/repositories/tourist_attraction_repository.dart';
import 'package:latlong2/latlong.dart';
import 'package:ml_linalg/linalg.dart' as linalg;

class SimilarListProvider with ChangeNotifier {
  // 변수
  List<TouristAttraction> touristAttractions = [];
  Map<String, List> imageVectors = {};
  double? latitude;
  double? longitude;
  bool isLoading = false;
  Map<String, num> cosineSimilarityMap = {};
  final downloadedURL = [];

  // 레포지토리
  final TouristAttractionRepository _touristAttractionRepository =
      TouristAttractionRepository();
  // final LocationRepository _locationRepository = LocationRepository();

  Future fetch() async {
    isLoading = true;
    notifyListeners();
    // Position position = await _locationRepository.getLocation();
    // cosineSimilarity(imgURL!);
    // await downloadImage();
  }

  calculateSimilarity(String imgURL) async {
    Map<String, num> temp = {};
    touristAttractions = await _touristAttractionRepository.getData();
    touristAttractions.forEach((e1) {
      e1.imgURL!.forEach((e2) {
        imageVectors[e2.keys.toList()[0]] = e2.values.toList()[0];
      });
    });
    final vector1 = linalg.Vector.fromList(imageVectors[imgURL]!.cast<num>());
    imageVectors.forEach((key, value) {
      var vector2 = linalg.Vector.fromList(value.cast<num>());
      var result = vector1.dot(vector2) / (vector1.norm() * vector2.norm());

      temp[key] = result;
    });
    // 정렬
    var sortedEntries = temp.entries.toList()
      ..sort((e1, e2) {
        var diff = e2.value.compareTo(e1.value);
        if (diff == 0) diff = e2.key.compareTo(e1.key);
        return diff;
      });
    temp = Map<String, num>.fromEntries(sortedEntries);
    // 상위 5개
    int count = 0;
    temp.forEach((key, value) {
      if (count < 5) {
        cosineSimilarityMap[key] = value;
      }
      count++;
    });
    print(cosineSimilarityMap.length);
    print(cosineSimilarityMap);
  }

  getData() async {
    print(cosineSimilarityMap.keys.toList());
    List<String> nameList = cosineSimilarityMap.keys.toList();
    int idx = 0;
    nameList.forEach((element) {
      nameList[idx] = element.replaceAll(RegExp('_[0-9]{2}.jpg'), '');
      idx++;
    });
    print(nameList);
    touristAttractions =
        await _touristAttractionRepository.getSelectedData(nameList);
    print(touristAttractions);
  }

  // Storage에서 이미지 다운로드
  Future<void> downloadImage() async {
    for (int i = 0; i < touristAttractions.length; i++) {
      for (int j = 0; j < touristAttractions[i].imgURL!.length; j++) {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('tourist_attraction')
            .child(touristAttractions[i].imgURL![j].keys.toList()[0]);
        print(touristAttractions[i].imgURL![j].keys.toList()[0]);
        String url = await ref.getDownloadURL();
        downloadedURL.add(url);
      }
    }
    isLoading = false;
    notifyListeners();
  }
}
