class TestTour {
  String? imgURL;
  List<dynamic> vec = [];

  TestTour.fromJson(Map<String, dynamic> json) {
    imgURL = json['img'];
    vec = json['vec'];
  }
}
