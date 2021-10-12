import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trebo/models/tourist_attraction.dart';

class TouristAttractionRepository {
  Stream<List<TouristAttraction>> fetch() {
    return FirebaseFirestore.instance
        .collection('touristAttractions')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => TouristAttraction.fromDocument(doc))
          .toList();
    });
  }
}
