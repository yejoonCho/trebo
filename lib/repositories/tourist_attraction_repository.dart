import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:trebo/models/tourist_attraction.dart';

class TouristAttractionRepository {
  List<TouristAttraction> touristAttractions = [];

  Future<List<TouristAttraction>> getData(List<int> filterNumbers) async {
    final String response =
        await rootBundle.loadString('data/tourist_attraction.json');
    List jsonResult = jsonDecode(response);
    jsonResult.forEach((element) {
      final touristAttraction =
          TouristAttraction.fromJson(element as Map<String, dynamic>);
      touristAttractions.add(touristAttraction);
    });

    return touristAttractions
        .where((element) => filterNumbers.contains(element.id))
        .toList();
  }

  Future<List<TouristAttraction>> getSelectedData(
      List<String> filterTitle) async {
    final String response =
        await rootBundle.loadString('data/tourist_attraction.json');
    List jsonResult = jsonDecode(response);
    jsonResult.forEach((element) {
      final touristAttraction =
          TouristAttraction.fromJson(element as Map<String, dynamic>);
      touristAttractions.add(touristAttraction);
    });

    return touristAttractions
        .where((element) => filterTitle.contains(element.title))
        .toList();
  }

//   // 데이터 DB에서 가져오기
//   Future<List<TouristAttraction>> getData(List<int> filterNumbers) async {
//     QuerySnapshot snapshot =
//         await FirebaseFirestore.instance.collection("touristAttraction").get();
//     snapshot.docs.forEach((doc) {
//       touristAttractions
//           .add(TouristAttraction.fromMap(doc.data() as Map<String, dynamic>));
//     });
//     if (filterNumbers == []) {
//       return touristAttractions.toList();
//     } else {
//       return touristAttractions
//           .where((element) => filterNumbers.contains(element.id))
//           .toList();
//     }
//   }
}
