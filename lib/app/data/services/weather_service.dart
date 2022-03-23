import 'dart:developer';

import 'package:geolocator/geolocator.dart';

import 'package:kurs_sabak8_weather/app/data/models/weather_model.dart';
import 'package:kurs_sabak8_weather/app/utils/constants/texts/app_texts.dart';
import 'package:kurs_sabak8_weather/app/utils/http/http_util.dart';

///DRY
class WeatherService {
  Future<Map<String, dynamic>> getWeatherByLocation({Position position}) async {
    final _url =
        '?&lat=${position.latitude}&lon=${position.longitude}&appid=${AppTexts.openWeatherApiKey}';
    return await HttpUtil.get(_url);
  }

  Future<Map<String, dynamic>> getWeatherByCity(String city) async {
    final url = '?q=$city&appid=${AppTexts.openWeatherApiKey}';

    return await HttpUtil.get(url);
  }

  Future<WeatherModel> getWeatherModelByLocation(Position position) async {
    final _data = await getWeatherByLocation(position: position);

    WeatherModel _weatherModel = WeatherModel.fromJson(_data);

    return _weatherModel;
  }

  Future<WeatherModel> getWeatherModelByCity(String city) async {
    return WeatherModel.fromJson(await getWeatherByCity(city));
  }
}
