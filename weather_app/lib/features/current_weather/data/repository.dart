// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:weather_app/features/current_weather/data/local_datasource.dart';
import 'package:weather_app/features/current_weather/data/remote_datasource.dart';

abstract class CurrentWeatherRepository {
  Future<void> getCurrentWeather();
}

class CurrentWeatherRepositoryImpl implements CurrentWeatherRepository {
  final CurrentWeatherLocalDataSource localDataSource = GetIt.I();
  final CurrentWeatherRemoteDataSource remoteDataSource = GetIt.I();

  @override
  Future<void> getCurrentWeather() async {
    // TODO(0xfbravo): implement
    return;
  }
}
