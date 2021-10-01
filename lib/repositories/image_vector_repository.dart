import 'dart:convert';

import 'package:flutter/services.dart';

class ImageVecotrRepositry {
  Map<String, List> imageVectors = {};

  Future<Map<String, List>> getData() async {
    final String response =
        await rootBundle.loadString('data/tourist_attraction_image.json');
    imageVectors = Map<String, List>.from(jsonDecode(response));
    return imageVectors;
  }
}
