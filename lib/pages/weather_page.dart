import 'dart:convert' as convert;
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kurs_sabak8_weather/constants/app_constants.dart';
import 'package:kurs_sabak8_weather/pages/city_page.dart';
import 'package:kurs_sabak8_weather/utils/weather_util.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({
    Key key,
  }) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String _celcius = '';
  String _cityName = '';
  String _icon;
  String _description = 'no data available';
  bool _isLoading = false;

  @override
  void initState() {
    showWeatherByLocation();

    super.initState();
  }

  Future<void> showWeatherByLocation() async {
    setState(() {
      _isLoading = true;
    });
    final position = await getCurrentPosition();

    await getWeatherByLocation(position: position);

    log('position latitude: ${position.latitude}');
    log('position longitude: ${position.longitude}');
  }

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getWeatherByLocation({@required Position position}) async {
    var client = http.Client();
    try {
      Uri _uri = Uri.parse(
          '$baseUrl?&lat=${position.latitude}&lon=${position.longitude}&appid=$openWeatherApiKey');
      final response = await client.get(_uri);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;

        /// [body] bul json turundo
        /// munu biz, dart tushuno turgan tipke ozgortushubuz kerek

        // [   ] List
        // {   } Map
        //  ' '  String

        final _data = convert.json.decode(body) as Map<String, dynamic>;

        _cityName = _data['name'];

        /// sandar
        /// num
        /// double 10.23423
        /// int 132

        /// temperature kelvin turundo kelet
        /// kelvin di celcius ka ozgortuu kerek
        /// celcius = kelvin - 273,15;
        final kelvin = _data['main']['temp'] as num;

        _celcius = WeatherUtil.kelvinToCelcius(kelvin);
        _icon = WeatherUtil.getWeatherIcon(kelvin.toInt());

        _description = WeatherUtil.getDescription(int.parse(_celcius));

        // (32°F − 32) × 5/9 = 0°C
        // round
        // 14.6 = 15
        // 14.3 = 14

        // _celcius = (kelvin - 273.15).round().toString();
        // _celcius = (temp - 273.15).toStringAsFixed(1);

        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      throw Exception(e);
    }
  }

  Future<void> getWeatherByCity(String city) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final client = http.Client;

      final url = '$baseUrl?q=$city&appid=$openWeatherApiKey';

      Uri uri = Uri.parse(url);

      final response = await http.get(uri);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final _data = convert.jsonDecode(response.body) as Map<String, dynamic>;
        _cityName = _data['name'];
        final kelvin = _data['main']['temp'] as num;

        _celcius = WeatherUtil.kelvinToCelcius(kelvin);
        _icon = WeatherUtil.getWeatherIcon(kelvin.toInt());

        _description = WeatherUtil.getDescription(int.parse(_celcius));

        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            onPressed: () {},
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

              log('_typedCity ==> $_typedCity');

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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Colors.cyanAccent,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: _size.height * 0.2),
                    Text(
                      _celcius.isEmpty ? '0\u00B0 ☀' : '$_celcius\u00B0 $_icon',
                      style: const TextStyle(
                        fontSize: 84,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    _cityName.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Text(
                              _cityName,
                              style: const TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    SizedBox(height: _size.height * 0.1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        _description,
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
