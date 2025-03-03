// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:maache_weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';


class WeatherService 
{
  // ignore: constant_identifier_names
  static const BASE_URL = "http://api.openweathermap.org/data/2.5/weather";
  final String apikey;

  WeatherService({required this.apikey});

  Future<WeatherModel> getWeather(String cityName) async 
  {
    print('Fetching weather data for city: $cityName'); // Debug print
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apikey&units=metric'));

    if (response.statusCode == 200) 
    {
      print('Weather data fetched successfully'); // Debug print
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to load weather data'); // Debug print
      throw Exception('Failed to load weather data');      
    }
  }

  Future<String> getCurrentCity() async 
  {
    print('Checking location permission'); // Debug print
    // Get permission 
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) 
    {
      print('Requesting location permission'); // Debug print
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied'); // Debug print
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied'); // Debug print
      throw Exception('Location permissions are permanently denied, we cannot request permissions.');
    }

    print('Fetching current position'); // Debug print
    try {
      // Get position
      // ignore: deprecated_member_use
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('Position: ${position.latitude}, ${position.longitude}'); // Debug print

      // Get city
      print('Fetching placemarks'); // Debug print
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      print('Placemarks: $placemarks'); // Debug print
      String? city = placemarks[0].locality;
      print('City: $city'); // Debug print

      return city ?? "";
    } catch (e) {
      print('Error fetching position or placemarks: $e'); // Debug print
      throw Exception('Error fetching position or placemarks: $e');
    }
  }
}