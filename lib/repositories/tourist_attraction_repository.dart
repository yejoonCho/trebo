import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:trebo/models/tourist_attraction.dart';

class TouristAttractionRepository {
  List<TouristAttraction> _touristAttractions = [];

  Future<List<TouristAttraction>> getData() async {
    final String response =
        await rootBundle.loadString('data/tourist_attraction.json');
    final List jsonResult = jsonDecode(response);

    jsonResult.forEach((element) {
      _touristAttractions
          .add(TouristAttraction.fromJson(element as Map<String, dynamic>));
    });
    return _touristAttractions;
  }

  Future<List<TouristAttraction>> getSelectedData(
      List<String> filterTitle) async {
    _touristAttractions = [];
    final String response =
        await rootBundle.loadString('data/tourist_attraction.json');
    List jsonResult = jsonDecode(response);
    jsonResult.forEach((element) {
      final touristAttraction =
          TouristAttraction.fromJson(element as Map<String, dynamic>);
      _touristAttractions.add(touristAttraction);
    });

    return _touristAttractions
        .where((element) => filterTitle.contains(element.title))
        .toList();
  }
}
