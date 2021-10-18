import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  late String id;
  late String title;
  late String address;
  late String category;
  late String time;
  late String menu;
  late String phone;
  late String url;
  late double latitude;
  late double longitude;
  late List<String> tags;
  late List<String> imgURLs;
  late List<Map<String, dynamic>> vectors;

  Restaurant(
      {required this.id,
      required this.title,
      required this.address,
      required this.category,
      required this.time,
      required this.menu,
      required this.phone,
      required this.url,
      required this.latitude,
      required this.longitude,
      required this.tags,
      required this.imgURLs,
      required this.vectors});

  factory Restaurant.fromDocument(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>;
    return Restaurant(
      id: doc.id,
      title: json['title'],
      address: json['address'],
      category: json['category'],
      time: json['time'],
      menu: json['menu'],
      phone: json['phone'],
      url: json['url'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      tags: List<String>.from(json['tags']),
      imgURLs: List<String>.from(json['img_urls']),
      vectors: List<Map<String, dynamic>>.from(json['vectors']),
    );
  }
}


// class Restaurant {
//   int? id;
//   String? title;
//   String? address;
//   double? latitude;
//   double? longitude;
//   String? menu;
//   String? phone;
//   String? category;
//   String? url;
//   String? time;
//   List<dynamic>? tag;
//   List<Map<String, dynamic>>? imgURL;
//   List<dynamic>? downloadedURL;
//   List<dynamic>? vector;

//   Restaurant.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['store_key'];
//     address = json['address'];
//     latitude = json['map_y'];
//     longitude = json['map_x'];
//     menu = json['menu'];
//     phone = json['phone'];
//     category = json['category'];
//     url = json['url'];
//     time = json['time'];
//     tag = json['tag'];
//     imgURL = List<Map<String, dynamic>>.from(json['img_url']);
//     downloadedURL = [];
//     vector = [];
//   }

//   Map<String, dynamic> toJson() {
//     List<dynamic> vectors = [];
//     for (int i = 0; i < vector!.length; i++) vectors.add({'$i': vector![i]});

//     return {
//       'title': title,
//       'address': address,
//       'category': category,
//       'menu': menu,
//       'time': time,
//       'url': url,
//       'phone': phone,
//       'latitude': latitude,
//       'longitude': longitude,
//       'tags': tag,
//       'img_urls': downloadedURL,
//       'vectors': vectors
//     };
//   }
// }
