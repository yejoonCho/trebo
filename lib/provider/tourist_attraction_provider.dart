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
}
