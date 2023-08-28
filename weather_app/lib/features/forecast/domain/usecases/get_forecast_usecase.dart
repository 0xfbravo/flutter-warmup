// 📦 Package imports:
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/features/forecast/data/repository.dart';
import 'package:weather_app/features/forecast/domain/model/forecast_model.dart';

abstract class GetForecastUseCase {
  Future<List<ForecastModel>> call({
    required LocationModel location,
  });
}

class GetForecastUseCaseImpl implements GetForecastUseCase {
  GetForecastUseCaseImpl();
  final ForecastRepository _repository = GetIt.I();

  @override
  Future<List<ForecastModel>> call({
    required LocationModel location,
  }) async {
    return _repository.getForecast(location: location);
  }
}
