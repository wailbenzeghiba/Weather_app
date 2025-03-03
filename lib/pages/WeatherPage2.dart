// ignore_for_file: file_names, avoid_print

import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:maache_weather_app/models/weather_model.dart';
import 'package:maache_weather_app/services/weather_service.dart';
import 'Settings.dart';
import 'findcity.dart';

class Weatherpage2 extends StatefulWidget {
  final String cityName;

  const Weatherpage2({super.key, required this.cityName});

  @override
  State<Weatherpage2> createState() => _Weatherpage2State();
}

class _Weatherpage2State extends State<Weatherpage2> {
  final _weatherService = WeatherService(apikey: 'cbcff29d7d1f1c6edf3adcac807a03d1');
  WeatherModel? _weatherModel;

  @override
  void initState() {
    super.initState();
    print('initState called'); // Debug print
    _fetchWeather();
  }

  //fetch weather
  Future<void> _fetchWeather() async {
    try {
      print('Fetching weather...'); // Debug print
      //get city weather
      final weatherModel = await _weatherService.getWeather(widget.cityName);
      print('Weather Data: ${weatherModel.cityName}, ${weatherModel.temperature}'); // Debug print

      setState(() {
        _weatherModel = weatherModel;
      });
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  String getWeatherAnimation(String? condition) {
    if (condition == null) {
      return 'assets/sunny.json';
    }

    switch (condition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/Cloud.json';

      case 'clear':
        return 'assets/sunny.json';

      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';

      case 'thunderstorm':
        return 'assets/Stormy.json';

      default:
        return 'assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'A T M O S P H E R E',
          style: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 100,
      ),
      drawer: Drawer(
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    "A T M O S P H E R E",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ListTile(
                leading: Icon(Icons.sunny_snowing),
                title: Text(
                  'My Weather',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.location_city),
                title: Text(
                  'Change City',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Findcity())),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  'Settings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Settings())),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //city name
              Text(
                _weatherModel?.cityName ?? 'Loading..',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 20),
              //animation
              Lottie.asset(getWeatherAnimation(_weatherModel?.condition)),
              SizedBox(height: 0),
              //temperature
              Text(
                _weatherModel != null ? "${_weatherModel!.temperature.toStringAsFixed(1)}°C" : ' ',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 20),
              //condition
              Text(
                _weatherModel?.condition ?? ' ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}