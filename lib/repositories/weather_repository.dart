import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trebo/models/weather.dart';

class WeatherRepository {
  Future<Weather> getWeather(double latitude, double longitude) async {
    final weather;
    final apiKey = 'f60023883838bf763174efbff96d5743';

    http.Response response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'));

    var json = jsonDecode(response.body)['weather'][0];
    weather = Weather.fromJson(json);
    return weather;
  }
}
