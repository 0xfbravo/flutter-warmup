// 📦 Package imports:
import 'package:hive/hive.dart';

part 'forecast_model.g.dart';

@HiveType(typeId: 2)
class ForecastModel {
  ForecastModel({
    required this.date,
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
  final String main;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String icon;

  @HiveField(4)
  final double temperature;

  @HiveField(5)
  final double feelsLike;

  @HiveField(6)
  final double minTemperature;

  @HiveField(7)
  final double maxTemperature;

  @HiveField(8)
  final int? pressure;

  @HiveField(9)
  final int? humidity;

  @HiveField(10)
  final int? seaLevel;

  @HiveField(11)
  final int? groundLevel;
}
