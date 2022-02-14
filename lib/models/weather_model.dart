import 'package:kurs_sabak8_weather/data/utils/weather_util.dart';

/// class
/// object
/// model
class WeatherModel {
  final String celcius;
  final String cityName;
  final String icon;
  final String description;

  WeatherModel({
    this.celcius,
    this.cityName,
    this.icon,
    this.description,
  });

  /// keyword
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      celcius: WeatherUtil.kelvinToCelcius(json['main']['temp'] as num),
      cityName: json['name'],
      icon: WeatherUtil.getWeatherIcon((json['main']['temp'] as num).toInt()),
      description: WeatherUtil.getDescription(
        int.parse(
          WeatherUtil.kelvinToCelcius(json['main']['temp'] as num),
        ),
      ),
    );
  }
}
