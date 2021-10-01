class TouristAttraction {
  int? id;
  String? title;
  String? address;
  double? latitude;
  double? longitude;
  String? description;
  List<Map<String, dynamic>>? imgURL;

  TouristAttraction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    description = json['description'];
    imgURL = List<Map<String, dynamic>>.from(json['imgURL']);
  }
}
