import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trebo/models/restaurant.dart';

class RestaurantRepository {
  int count = 0;
  Stream<List<Restaurant>> fetch() {
    return FirebaseFirestore.instance
        .collection("restaurants")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        count++;
        print(count);
        return Restaurant.fromDocument(doc);
      }).toList();
    });
  }
}
