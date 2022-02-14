import 'package:flutter/material.dart';
import 'package:kurs_sabak8_weather/data/services/geo_location_service.dart';
import 'package:kurs_sabak8_weather/data/services/weather_service.dart';
import 'package:kurs_sabak8_weather/models/weather_model.dart';
import 'package:kurs_sabak8_weather/widgets/container_with_bg_image.dart';
import 'package:kurs_sabak8_weather/widgets/custom_progress_indicator.dart';
import 'package:kurs_sabak8_weather/widgets/weather_page_content.dart';

import 'city_page.dart';

class WeatherModelPage extends StatefulWidget {
  const WeatherModelPage({Key key}) : super(key: key);

  @override
  _WeatherModelPageState createState() => _WeatherModelPageState();
}

class _WeatherModelPageState extends State<WeatherModelPage> {
  bool _isLoading = false;

  WeatherModel _weatherModel;

  @override
  void initState() {
    showWeatherByLocation();
    super.initState();
  }

  Future<void> showWeatherByLocation() async {
    setState(() {
      _isLoading = true;
    });
    final _position = await GeoLocationService().getCurrentPosition();

    _weatherModel = await WeatherService().getWeatherModelByLocation(_position);

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getWeatherByCity(String _city) async {
    setState(() {
      _isLoading = true;
    });

    _weatherModel = await WeatherService().getWeatherModelByCity(_city);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            onPressed: () async {
              await showWeatherByLocation();
            },
            icon: const Icon(
              Icons.navigation,
              size: 40,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final _typedCity = await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CityPage()));

              await getWeatherByCity(_typedCity);
            },
            icon: const Icon(
              Icons.location_city,
              size: 40,
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: ContainerWithBgImage(
        child: _isLoading
            ? const CustomProgressIndicator()
            : WeatherPageContent(
                celcius: _weatherModel.celcius,
                icon: _weatherModel.icon,
                description: _weatherModel.description,
                cityName: _weatherModel.cityName,
              ),
      ),
    );
  }
}
