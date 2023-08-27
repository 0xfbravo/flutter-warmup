// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class CurrentWeatherView extends StatefulWidget {
  const CurrentWeatherView({super.key});

  @override
  State<CurrentWeatherView> createState() => _CurrentWeatherViewState();
}

class _CurrentWeatherViewState extends State<CurrentWeatherView> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Current Weather'),
      ],
    );
  }
}
