// 📦 Package imports:
import 'package:get_it/get_it.dart';
import 'package:weather_app/core/domain/model/saved_location_model.dart';

// 🌎 Project imports:
import 'package:weather_app/features/current_weather/data/repository.dart';
import 'package:weather_app/features/current_weather/domain/model/current_weather_model.dart';

abstract class GetCurrentWeatherUseCase {
  Future<CurrentWeatherModel> call({
    required SavedLocationModel savedLocationModel,
  });
}

class GetCurrentWeatherUseCaseImpl implements GetCurrentWeatherUseCase {
  final CurrentWeatherRepository _repository = GetIt.I();

  @override
  Future<CurrentWeatherModel> call({
    required SavedLocationModel savedLocationModel,
  }) async {
    return _repository.getCurrentWeather(
      savedLocationModel: savedLocationModel,
    );
  }
}
