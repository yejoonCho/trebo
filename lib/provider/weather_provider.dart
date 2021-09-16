import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trebo/models/weather.dart';
import 'package:trebo/repositories/location_repository.dart';
import 'package:trebo/repositories/weather_repository.dart';

class WeatherProvider with ChangeNotifier {
  bool isLoading = false;
  Weather? weather;
  final _locationRepository = LocationRepository();
  final _weatherRepository = WeatherRepository();

  WeatherProvider() {
    fetch();
  }

  Future<void> fetch() async {
    isLoading = true;
    notifyListeners();

    Position position = await _locationRepository.getLocation();
    weather = await _weatherRepository.getWeather(
        position.latitude, position.longitude);
    notifyListeners();
  }
}
