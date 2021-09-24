import 'package:cloud_firestore/cloud_firestore.dart';

class TouristAttraction {
  String? title;
  String? description;
  List<dynamic>? imgUrl;
  double? latitude;
  double? longitude;
  int? id;
  String? address;

  TouristAttraction(this.title, this.description, this.latitude, this.longitude,
      this.id, this.address);

  TouristAttraction.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    latitude = map['latitude'];
    longitude = map['longitude'];
    address = map['address'];
    imgUrl = map['imgUrl'];
  }

  TouristAttraction.fromSnapshot(QueryDocumentSnapshot snapshot) {
    title = snapshot.get('title');
    description = snapshot.get('description');
    imgUrl = snapshot.get('imgUrl');
    latitude = snapshot.get('latitude');
    longitude = snapshot.get('longitude');
    address = snapshot.get('address');
    id = snapshot.get('id');
  }
}
