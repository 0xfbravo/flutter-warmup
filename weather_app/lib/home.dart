import 'package:flutter/material.dart';
import 'package:weather_app/features/current_weather/presentation/view.dart';
import 'package:weather_app/features/forecast/presentation/view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.cloud),
                text: 'Current weather',
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
            CurrentWeatherView(),
            ForecastPageView(),
          ],
        ),
      ),
    );
  }
}
