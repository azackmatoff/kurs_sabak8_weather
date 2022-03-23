import 'package:geolocator/geolocator.dart';
import 'package:kurs_sabak8_weather/app/data/models/weather_model.dart';
import 'package:kurs_sabak8_weather/app/data/services/weather_service.dart';
import 'package:kurs_sabak8_weather/app/utils/di/di_locator.dart';

class WeatherRepository {
  Future<WeatherModel> getWeatherModelByLocation(Position position) async {
    return await getIt<WeatherService>().getWeatherModelByLocation(position);
  }

  Future<WeatherModel> getWeatherModelByCity(String city) async {
    return await getIt<WeatherService>().getWeatherModelByCity(city);
  }
}
