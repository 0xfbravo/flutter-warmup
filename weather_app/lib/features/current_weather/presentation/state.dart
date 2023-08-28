import 'package:weather_app/core/domain/model/location_model.dart';

abstract class CurrentWeatherPageState {}

class CurrentWeatherPageLoading extends CurrentWeatherPageState {}

class CurrentWeatherPageError extends CurrentWeatherPageState {}

class CurrentWeatherPageLoaded extends CurrentWeatherPageState {
  CurrentWeatherPageLoaded({required this.locations});

  final List<LocationModel> locations;
}
