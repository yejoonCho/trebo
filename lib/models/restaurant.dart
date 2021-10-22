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
      title: json['title'].replaceAll(RegExp('[가-힣]+_[가-힣]+_[1-9가-힣]+_'), ''),
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
