// 📦 Package imports:
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:weather_app/features/forecast/data/local_datasource.dart';
import 'package:weather_app/features/forecast/data/remote_datasource.dart';

abstract class ForecastRepository {
  Future<void> getForecast();
}

class ForecastRepositoryImpl implements ForecastRepository {
  final ForecastLocalDataSource localDataSource = GetIt.I();
  final ForecastRemoteDataSource remoteDataSource = GetIt.I();

  @override
  Future<void> getForecast() async {
    // TODO(0xfbravo): implement
    return;
  }
}
