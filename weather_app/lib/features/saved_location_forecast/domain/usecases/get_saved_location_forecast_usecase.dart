// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:weather_app/features/saved_location_forecast/data/repository.dart';

abstract class GetSavedLocationForecastUseCase {
  Future<void> call();
}

class GetSavedLocationForecastUseCaseImpl
    implements GetSavedLocationForecastUseCase {
  GetSavedLocationForecastUseCaseImpl();
  final SavedLocationForecastRepository _repository = GetIt.I();

  @override
  Future<void> call() async {
    return _repository.getSavedLocationForecast();
  }
}
