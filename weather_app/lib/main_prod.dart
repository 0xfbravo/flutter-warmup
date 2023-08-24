import 'package:flutter/material.dart';
import 'package:weather_app/app.dart';
import 'package:weather_app/core/dependency_injection.dart';

void main() async {
  final _ = WidgetsFlutterBinding.ensureInitialized();
  // TODO(0xfbravo): Any environment setup goes here.
  setupDependencyInjection();
  runApp(const WeatherApp());
}
