// 📦 Package imports:
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:weather_app/features/current_weather/data/repository.dart';

abstract class GetCurrentWeatherUseCase {
  Future<void> call();
}

class GetCurrentWeatherUseCaseImpl implements GetCurrentWeatherUseCase {
  final CurrentWeatherRepository _repository = GetIt.I();

  @override
  Future<void> call() async {
    return _repository.getCurrentWeather();
  }
}
