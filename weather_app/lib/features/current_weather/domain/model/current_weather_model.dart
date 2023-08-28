// 📦 Package imports:
import 'package:hive/hive.dart';

part 'current_weather_model.g.dart';

@HiveType(typeId: 1)
class CurrentWeatherModel {
  CurrentWeatherModel({
    required this.latitude,
    required this.longitude,
    required this.main,
    required this.description,
    required this.icon,
    required this.temperature,
    required this.feelsLike,
    required this.minTemperature,
    required this.maxTemperature,
    required this.pressure,
    required this.humidity,
    this.seaLevel,
    this.groundLevel,
  });

  @HiveField(0)
  final double latitude;

  @HiveField(1)
  final double longitude;

  @HiveField(2)
  final String main;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String icon;

  @HiveField(5)
  final double temperature;

  @HiveField(6)
  final double feelsLike;

  @HiveField(7)
  final double minTemperature;

  @HiveField(8)
  final double maxTemperature;

  @HiveField(9)
  final int? pressure;

  @HiveField(10)
  final int? humidity;

  @HiveField(11)
  final int? seaLevel;

  @HiveField(12)
  final int? groundLevel;
}
