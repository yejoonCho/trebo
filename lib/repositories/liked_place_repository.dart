import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trebo/models/restaurant.dart';
import 'package:trebo/models/tourist_attraction.dart';

class LikedPlaceRepository {
  final User user;

  LikedPlaceRepository({required this.user});

  Future fetch() async {
    // ID 찾기
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("feelings")
        .doc(user.uid)
        .get();
    var json = doc.data() as Map<String, dynamic>;

    List<dynamic> places = [];

    // 관광지
    List<String> touristAttractionIDs =
        List<String>.from(json['tourist_attraction']);
    print(touristAttractionIDs);
    for (int i = 0; i < touristAttractionIDs.length; i++) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("tourist_attractions_2")
          .doc(touristAttractionIDs[i])
          .get();
      places.add(TouristAttraction.fromDocument(doc));
    }

    // 음식점
    List<String> restaurantIDs = List<String>.from(json['restaurant']);
    for (int i = 0; i < restaurantIDs.length; i++) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("restaurants")
          .doc(restaurantIDs[i])
          .get();
      places.add(Restaurant.fromDocument(doc));
    }
    print(places);
    print(places.length);
    return places;
  }
}
