import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trebo/models/tourist_attraction.dart';

class TouristAttractionRepository {
  final touristAttractions = <TouristAttraction>[];

  Future<List<TouristAttraction>> fetch() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("touristAttraction").get();
    querySnapshot.docs.forEach((document) {
      touristAttractions.add(
          TouristAttraction.fromMap(document.data() as Map<String, dynamic>));
    });
    return touristAttractions;
  }
}
