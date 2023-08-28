// 📦 Package imports:
import 'package:hive/hive.dart';

part 'forecast_model.g.dart';

@HiveType(typeId: 2)
class ForecastModel {
  ForecastModel({
    required this.date,
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
  final String date;

  @HiveField(1)
  final double latitude;

  @HiveField(2)
  final double longitude;

  @HiveField(3)
  final String main;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String icon;

  @HiveField(6)
  final double temperature;

  @HiveField(7)
  final double feelsLike;

  @HiveField(8)
  final double minTemperature;

  @HiveField(9)
  final double maxTemperature;

  @HiveField(10)
  final int? pressure;

  @HiveField(11)
  final int? humidity;

  @HiveField(12)
  final int? seaLevel;

  @HiveField(13)
  final int? groundLevel;
}
