// services/weather_services.dart
import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather/models/weather_model.dart';

class WeatherServices {
  final String baseUrl = 'http://api.weatherapi.com/v1';
  final String apiKey = 'd7efdbe51b294b6187091557242310';

  Future<WeatherModel?> getWeather({required String city}) async {
    final Uri url = Uri.parse('$baseUrl/current.json?key=$apiKey&q=$city');

    try {
      final Response response = await get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return WeatherModel.fromJson(
            data); // إرجاع بيانات الطقس كـ WeatherModel
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      return null; // إرجاع null في حالة الخطأ
    }
  }
}

// http://api.weatherapi.com/v1/current.json?keyd7efdbe51b294b6187091557242310  