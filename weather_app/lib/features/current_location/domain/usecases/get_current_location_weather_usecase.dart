import 'package:weather_app/features/current_location/data/repository.dart';

abstract class GetCurrentLocationWeatherUseCase {
  Future<void> call();
}

class GetCurrentLocationWeatherUseCaseImpl
    implements GetCurrentLocationWeatherUseCase {
  GetCurrentLocationWeatherUseCaseImpl(this.currentLocationRepository);
  final CurrentLocationRepository currentLocationRepository;

  @override
  Future<void> call() async {
    return currentLocationRepository.getCurrentLocationWeather();
  }
}
