import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/tourist_attraction.dart';

class TouristAttractionProvider with ChangeNotifier {
  List<TouristAttraction> touristAttraction = [
    TouristAttraction.fromJson({
      'title': '북촌 한옥마을',
      'description': '북촌에 위치한 한옥마을입니다.',
      'imgUrl': 'hanok.jpg',
      'latitude': 124.513,
      'longitude': 37.34213
    })
  ];
}
