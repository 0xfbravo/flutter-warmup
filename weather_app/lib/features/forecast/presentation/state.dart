// 🌎 Project imports:
import 'package:weather_app/features/forecast/domain/model/forecast_model.dart';

abstract class ForecastState {}

class ForecastLoading extends ForecastState {}

class ForecastError extends ForecastState {}

class ForecastLoaded extends ForecastState {
  ForecastLoaded({required this.forecast});

  final List<ForecastModel> forecast;
}
