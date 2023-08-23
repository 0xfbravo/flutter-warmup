import 'package:get_it/get_it.dart';
import 'package:weather_app/features/current_location/data/repository.dart';

abstract class GetCurrentLocationWeatherUseCase {
  Future<void> call();
}

class GetCurrentLocationWeatherUseCaseImpl
    implements GetCurrentLocationWeatherUseCase {
  final CurrentLocationWeatherRepository repository = GetIt.I();

  @override
  Future<void> call() async {
    return repository.getCurrentLocationWeather();
  }
}
