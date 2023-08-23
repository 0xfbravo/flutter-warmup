import 'package:weather_app/features/saved_location_forecast/data/repository.dart';

abstract class GetSavedLocationForecastUseCase {
  Future<void> call();
}

class GetSavedLocationForecastUseCaseImpl
    implements GetSavedLocationForecastUseCase {
  GetSavedLocationForecastUseCaseImpl(
    this.savedLocationForecastRepository,
  );
  final SavedLocationForecastRepository savedLocationForecastRepository;

  @override
  Future<void> call() async {
    return savedLocationForecastRepository.getSavedLocationForecast();
  }
}
