

class WeatherModel {
  final String cityName;
  final double temperature;
  final String condition;

  WeatherModel({required this.cityName, required this.temperature,required this.condition});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(), // Ensure temperature is parsed as double
      condition: json['weather'][0]['main'],    
    );
  }
}