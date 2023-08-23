import 'package:get_it/get_it.dart';
import 'package:weather_app/features/saved_location_forecast/data/repository.dart';

abstract class GetSavedLocationForecastUseCase {
  Future<void> call();
}

class GetSavedLocationForecastUseCaseImpl
    implements GetSavedLocationForecastUseCase {
  GetSavedLocationForecastUseCaseImpl();
  final SavedLocationForecastRepository repository = GetIt.I();

  @override
  Future<void> call() async {
    return repository.getSavedLocationForecast();
  }
}
