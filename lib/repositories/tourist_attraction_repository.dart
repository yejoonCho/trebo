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
      for (int j = 0; j < touristAttractions[i].imgUrl!.length; j++) {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child(touristAttractions[i].imgUrl![j]);
        String url = await ref.getDownloadURL();
        print('다운로드');
        touristAttractions[i].imgUrl![j] = url;
      }
    }
  }
}
