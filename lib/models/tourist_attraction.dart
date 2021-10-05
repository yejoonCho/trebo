class TouristAttraction {
  int? id;
  String? title;
  String? address;
  double? latitude;
  double? longitude;
  String? description;
  List<Map<String, dynamic>>? imgURL;
  List<String>? downloadedURL;

  TouristAttraction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    description = json['description'];
    imgURL = List<Map<String, dynamic>>.from(json['imgURL']);
    downloadedURL = [];
    // imgURL!.forEach((element) {
    //   element[element.keys.toList()[0]] =
    //       List<num>.from(element.values.toList()[0]);
    // });
  }
}
