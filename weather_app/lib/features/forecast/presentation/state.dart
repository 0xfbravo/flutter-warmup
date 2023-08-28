import 'package:weather_app/core/domain/model/location_model.dart';

abstract class ForecastPageState {}

class ForecastPageLoading extends ForecastPageState {}

class ForecastPageError extends ForecastPageState {}

class ForecastPageLoaded extends ForecastPageState {
  ForecastPageLoaded({required this.locations});

  final List<LocationModel> locations;
}
