class TouristAttraction {
  int? id;
  String? title;
  String? address;
  double? latitude;
  double? longitude;
  List<String>? imgUrl;
  String? description;

  TouristAttraction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];

    var imgUrlFromJson = json['imgURL'];
    imgUrl = List<String>.from(imgUrlFromJson);
  }

  // factory TouristAttraction.fromDocument(DocumentSnapshot doc) {
  //   final map = doc.data() as Map<String, dynamic>;
  //   return TouristAttraction(
  //     id: map['id'],
  //     title: map['title'],
  //     description: map['description'],
  //     latitude: map['latitude'],
  //     longitude: map['longitude'],
  //     address: map['address'],
  //     imgUrl: map['imgUrl'],
  //   );
  // }
}
