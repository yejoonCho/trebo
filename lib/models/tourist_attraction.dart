import 'package:cloud_firestore/cloud_firestore.dart';

class TouristAttraction {
  String? title;
  String? description;
  List<dynamic>? imgUrl;
  double? latitude;
  double? longitude;
  int? id;
  String? address;

  TouristAttraction(
      {this.title,
      this.description,
      this.latitude,
      this.longitude,
      this.id,
      this.address,
      this.imgUrl});

  TouristAttraction.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    latitude = map['latitude'];
    longitude = map['longitude'];
    address = map['address'];
    imgUrl = map['imgUrl'];
  }

  factory TouristAttraction.fromDocument(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return TouristAttraction(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      address: map['address'],
      imgUrl: map['imgUrl'],
    );
  }
}
