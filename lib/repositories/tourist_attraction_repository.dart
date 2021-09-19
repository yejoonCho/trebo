import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

    await fetchImg();
    return touristAttractions;
  }

  fetchImg() async {
    for (int i = 0; i < touristAttractions.length; i++) {
      Reference ref =
          FirebaseStorage.instance.ref().child(touristAttractions[i].imgUrl!);
      String url = await ref.getDownloadURL();
      touristAttractions[i].imgUrl = url;
    }
  }
}
