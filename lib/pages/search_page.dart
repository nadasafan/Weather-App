// pages/search_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/services/weather_services.dart';

class SearchPage extends StatefulWidget {
  final Function(WeatherModel)? updateUi;

  SearchPage({this.updateUi});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  void _searchCity() async {
    String cityName = _controller.text.trim(); // الحصول على اسم المدينة
    if (cityName.isNotEmpty) {
      WeatherServices services = WeatherServices();
      try {
        WeatherModel? weather = await services.getWeather(city: cityName);
        Provider.of<WeatherProvider>(context, listen: false)
            .updateWeatherData(weather);
        if (weather != null && widget.updateUi != null) {
          widget.updateUi!(weather); // تحديث واجهة المستخدم مع حالة الطقس
        }
        Navigator.pop(context); // العودة إلى الصفحة الرئيسية بعد تحديث الطقس
      } catch (e) {
        // عرض رسالة خطأ
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching weather: $e')),
        );
      }
    } else {
      // عرض رسالة إذا كان الإدخال فارغًا
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a city name')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // تنظيف المتحكم
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Search a City'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              onSubmitted: (data) => _searchCity(),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(30.0),
                labelText: 'Search',
                border: const OutlineInputBorder(),
                hintText: 'Search a city',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchCity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
