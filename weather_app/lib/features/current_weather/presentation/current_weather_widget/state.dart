import 'package:weather_app/features/current_weather/domain/model/current_weather_model.dart';

abstract class CurrentWeatherState {}

class CurrentWeatherLoading extends CurrentWeatherState {}

class CurrentWeatherError extends CurrentWeatherState {}

class CurrentWeatherLoaded extends CurrentWeatherState {
  CurrentWeatherLoaded({required this.weather});

  final CurrentWeatherModel weather;
}
