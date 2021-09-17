import 'package:flutter/cupertino.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/repositories/tourist_attraction_repository.dart';

class TouristAttractionProvider with ChangeNotifier {
  var isLoading = false;
  List<TouristAttraction> touristAttractions = [];

  final _storeRepository = TouristAttractionRepository();

  TouristAttractionProvider() {
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();

    touristAttractions = _storeRepository.fetch();
    isLoading = false;
    notifyListeners();
  }
}
