// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/widgets/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: weatherProvider.weatherDate != null
            ? weatherProvider.weatherDate!.getThemeColor()
            : Colors.blue, // Fallback theme color if weatherDate is null
      ),
      home: Homepage(),
    );
  }
}
