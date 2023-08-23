import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/features/current_location/presentation/view.dart';
import 'package:weather_app/features/saved_location_forecast/presentation/view.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.cyan,
        ),
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Weather App'),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.pin_drop),
                  text: 'Current location',
                ),
                Tab(
                  icon: Icon(Icons.sunny_snowing),
                  text: 'Forecast',
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              CurrentLocationWeatherView(),
              SavedLocationForecastView(),
            ],
          ),
        ),
      ),
    );
  }
}
