// 📦 Package imports:
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:weather_app/features/forecast/data/repository.dart';

abstract class GetForecastUseCase {
  Future<void> call();
}

class GetForecastUseCaseImpl implements GetForecastUseCase {
  GetForecastUseCaseImpl();
  final ForecastRepository _repository = GetIt.I();

  @override
  Future<void> call() async {
    return _repository.getForecast();
  }
}
