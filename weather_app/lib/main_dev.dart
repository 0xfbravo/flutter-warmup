// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 🌎 Project imports:
import 'package:weather_app/app.dart';
import 'package:weather_app/core/dependency_injection.dart';

void main() async {
  final _ = WidgetsFlutterBinding.ensureInitialized();

  /// Keep in mind FlutterConfig doesn't obfuscate
  /// the values, so it's not recommended to use it for sensitive data.
  /// But it's a good option for development.
  /// These keys should be stored on a secure storage, like for example
  /// Transmit Security. (https://transmitsecurity.com/)
  await dotenv.load(fileName: '.env');
  debugPrint('.env Loaded: ${dotenv.env}');
  setupDependencyInjection();
  runApp(const WeatherApp());
}
