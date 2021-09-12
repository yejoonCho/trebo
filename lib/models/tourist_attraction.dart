class TouristAttraction {
  String? title;
  String? description;
  String? imgUrl;
  double? latitude;
  double? longitude;

  TouristAttraction.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    imgUrl = json['imgUrl'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}
