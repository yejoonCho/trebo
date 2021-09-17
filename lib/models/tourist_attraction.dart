import 'package:cloud_firestore/cloud_firestore.dart';

class TouristAttraction {
  String? title;
  String? description;
  String? imgUrl;
  double? latitude;
  double? longitude;
  int? id;
  String? address;

  TouristAttraction(this.title, this.description, this.latitude, this.longitude,
      this.id, this.address);

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
