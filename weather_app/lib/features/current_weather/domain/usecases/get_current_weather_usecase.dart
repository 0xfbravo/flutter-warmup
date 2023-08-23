import 'package:get_it/get_it.dart';
import 'package:weather_app/features/current_weather/data/repository.dart';

abstract class GetCurrentWeatherUseCase {
  Future<void> call();
}

class GetCurrentWeatherUseCaseImpl implements GetCurrentWeatherUseCase {
  final CurrentWeatherRepository repository = GetIt.I();

  @override
  Future<void> call() async {
    return repository.getCurrentWeather();
  }
}
