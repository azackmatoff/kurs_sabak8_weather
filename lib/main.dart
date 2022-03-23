import 'package:flutter/material.dart';
import 'package:kurs_sabak8_weather/app/presentation/views/weather_view.dart';
import 'package:kurs_sabak8_weather/app/utils/constants/colors/app_colors.dart';
import 'package:kurs_sabak8_weather/app/utils/di/di_locator.dart';

///Design architecture
///MVVM
///MVC
///MVI
///State Management
///Refactoring, clean code
void main() async {
  await initDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: AppColors.blue,
      ),
      home: const WeatherView(),
    );
  }
}
