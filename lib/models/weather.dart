import 'dart:convert';
import 'package:http/http.dart' as http;

class Weather {
  final String url;
  Weather(this.url);

  Future<dynamic> getWeatherData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var weatherData = jsonDecode(response.body);
      return weatherData;
    }
  }
}
