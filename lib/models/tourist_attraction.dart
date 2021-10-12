import 'package:cloud_firestore/cloud_firestore.dart';

class TouristAttraction {
  late String id;
  late String title;
  late String address;
  late double latitude;
  late double longitude;
  late String description;
  late List<String> imgURLs;
  late List<Map<String, dynamic>> vectors;

  TouristAttraction(
      {required this.id,
      required this.title,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.description,
      required this.imgURLs,
      required this.vectors});

  factory TouristAttraction.fromDocument(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>;
    return TouristAttraction(
        id: doc.id,
        title: json['title'],
        address: json['address'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        description: json['description'],
        imgURLs: List<String>.from(json['img_urls']),
        vectors: List<Map<String, dynamic>>.from(json['vectors']));
  }
}
