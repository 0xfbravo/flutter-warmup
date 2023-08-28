// 📦 Package imports:
import 'package:get_it/get_it.dart';
import 'package:weather_app/core/domain/model/location_model.dart';

// 🌎 Project imports:
import 'package:weather_app/features/forecast/data/repository.dart';

abstract class GetForecastUseCase {
  Future<void> call({
    required LocationModel location,
  });
}

class GetForecastUseCaseImpl implements GetForecastUseCase {
  GetForecastUseCaseImpl();
  final ForecastRepository _repository = GetIt.I();

  @override
  Future<void> call({
    required LocationModel location,
  }) async {
    return _repository.getForecast(location: location);
  }
}
