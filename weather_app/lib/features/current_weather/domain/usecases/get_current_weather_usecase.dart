// 📦 Package imports:
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/features/current_weather/data/repository.dart';
import 'package:weather_app/features/current_weather/domain/model/current_weather_model.dart';

abstract class GetCurrentWeatherUseCase {
  Future<CurrentWeatherModel> call({
    required LocationModel location,
  });
}

class GetCurrentWeatherUseCaseImpl implements GetCurrentWeatherUseCase {
  final CurrentWeatherRepository _repository = GetIt.I();

  @override
  Future<CurrentWeatherModel> call({
    required LocationModel location,
  }) async {
    return _repository.getCurrentWeather(
      location: location,
    );
  }
}
