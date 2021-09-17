import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trebo/models/tourist_attraction.dart';

class TouristAttractionRepository {
  List<TouristAttraction> fetch() {
    final touristAttraction = <TouristAttraction>[];
    FirebaseFirestore.instance.collection("touristAttraction").get().then(
        (snap) => {
              snap.docs.map((e) =>
                  touristAttraction.add(TouristAttraction.fromSnapshot(e)))
            });
    return touristAttraction;
  }
}
