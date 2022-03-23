import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:kurs_sabak8_weather/app/data/repository/geolocation_repository.dart';
import 'package:kurs_sabak8_weather/app/data/repository/weather_repository.dart';
import 'package:kurs_sabak8_weather/app/data/services/geo_location_service.dart';
import 'package:kurs_sabak8_weather/app/data/services/weather_service.dart';

final getIt = GetIt.instance;

Future<void> initDI() async {
  _initRepositories();
  _initServices();
}

void _initRepositories() {
  log('_initRepositories......');
  getIt.registerSingleton<WeatherRepository>(WeatherRepository());
  getIt.registerSingleton<GeolocationRepository>(GeolocationRepository());
}

void _initServices() {
  log('_initServices......');
  getIt.registerSingleton<WeatherService>(WeatherService());
  getIt.registerSingleton<GeoLocationService>(GeoLocationService());
}
