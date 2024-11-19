// widgets/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/search_page.dart';
import 'package:weather/providers/weather_provider.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // جلب حالة الطقس من provider
    var weather = Provider.of<WeatherProvider>(context).weatherDate;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return SearchPage(); // صفحة البحث
                }),
              );
            },
            icon: const Icon(Icons.search),
            tooltip: 'Search',
          ),
        ],
        backgroundColor: Colors.blue,
        title: const Text('Weather App'),
      ),
      body: weather == null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'There is no weather 😔 Start searching now 🔍',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            )
          : Center(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    weather.getThemeColor().withOpacity(0.8),
                    weather.getThemeColor().withOpacity(0.5),
                  ],
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      weather.location ?? 'Unknown Location',
                      style: const TextStyle(
                          fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Updated: ${weather.date ?? 'No Date'}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                            'assets/images/${weather.condition?.toLowerCase() ?? 'clear'}.png'),
                        Text(
                          '${weather.temp ?? 'N/A'} °C',
                          style: const TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            Text("Max Temp: ${weather.maxTemp ?? 'N/A'}"),
                            Text("Min Temp: ${weather.minTemp ?? 'N/A'}"),
                          ],
                        ),
                      ],
                    ),
                    Text(weather.condition ?? 'Clear',
                        style: const TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ),
    );
  }
}
