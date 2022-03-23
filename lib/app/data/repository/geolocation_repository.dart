import 'package:geolocator/geolocator.dart';
import 'package:kurs_sabak8_weather/app/data/services/geo_location_service.dart';
import 'package:kurs_sabak8_weather/app/utils/di/di_locator.dart';

class GeolocationRepository {
  Future<Position> getCurrentPosition() async {
    return await getIt<GeoLocationService>().getCurrentPosition();
  }
}
