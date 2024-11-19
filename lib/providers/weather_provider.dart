// providers/weather_provider.dart
import 'package:flutter/material.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_services.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? _weatherDate;

  WeatherModel? get weatherDate => _weatherDate;

  // Method to update weather data
  Future<void> updateWeatherData(WeatherModel? weather) async {
    _weatherDate = weather;
    notifyListeners();
  }

  // Method to fetch weather data
  Future<void> fetchWeather(String cityName) async {
    WeatherServices services = WeatherServices();
    try {
      _weatherDate = await services.getWeather(city: cityName);
      notifyListeners();
    } catch (e) {
      _weatherDate = null;
      notifyListeners();
    }
  }
}
