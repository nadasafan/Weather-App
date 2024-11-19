// models/weather_model.dart
import 'package:flutter/material.dart';

class WeatherModel {
  String date;
  double temp;
  double maxTemp;
  double minTemp;
  String weatherStateName;
  String? location; // Optional field for location
  String? condition; // Optional field for condition

  WeatherModel({
    required this.date,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherStateName,
    this.location,
    this.condition,
  });

  // Convert JSON data to WeatherModel
  factory WeatherModel.fromJson(Map<String, dynamic> data) {
    var forecastDayData = data['forecast']?['forecastday'];
    var jsonData = forecastDayData != null && forecastDayData.isNotEmpty
        ? forecastDayData[0]['day']
        : null;

    return WeatherModel(
      date: data['location']?['localtime'] ?? '',
      temp: jsonData?['avgtemp_c']?.toDouble() ?? 50.0,
      maxTemp: jsonData?['maxtemp_c']?.toDouble() ?? 0.0,
      minTemp: jsonData?['mintemp_c']?.toDouble() ?? 0.0,
      weatherStateName: jsonData?['condition']?['text'] ?? '',
      location: data['location']?['name'],
      condition: jsonData?['condition']?['text'],
    );
  }

  // Returns the icon URL for the weather condition
  String getImageUrl() {
    var condition = weatherStateName.toLowerCase();

    if (condition.contains('sunny') || condition.contains('clear')) {
      return 'assets/images/clear.png';
    } else if (condition.contains('cloud')) {
      return 'assets/images/cloudy.png';
    } else if (condition.contains('rain') || condition.contains('shower')) {
      return 'assets/images/rainy.png';
    } else if (condition.contains('snow')) {
      return 'assets/images/snowy.png';
    } else if (condition.contains('thunder') || condition.contains('storm')) {
      return 'assets/images/thunderstorm.png';
    } else {
      return 'assets/images/clear.png'; // Default color for unspecified conditions
    }
  }

  // Rename the method to getThemeColor for consistency
  MaterialColor getThemeColor() {
    var condition = weatherStateName.toLowerCase();

    if (condition.contains('sunny') || condition.contains('clear')) {
      return Colors.orange;
    } else if (condition.contains('cloud')) {
      return Colors.blueGrey;
    } else if (condition.contains('rain') || condition.contains('shower')) {
      return Colors.blue;
    } else if (condition.contains('snow')) {
      return Colors.lightBlue;
    } else if (condition.contains('thunder') || condition.contains('storm')) {
      return Colors.deepPurple;
    } else {
      return Colors.grey; // Default color for unspecified conditions
    }
  }

  @override
  String toString() {
    return 'WeatherModel(date: $date, temp: $temp, maxTemp: $maxTemp, minTemp: $minTemp, weatherStateName: $weatherStateName, location: $location, condition: $condition)';
  }
}
