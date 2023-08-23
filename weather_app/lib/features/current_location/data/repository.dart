import 'package:get_it/get_it.dart';
import 'package:weather_app/features/current_location/data/local_datasource.dart';
import 'package:weather_app/features/current_location/data/remote_datasource.dart';

abstract class CurrentLocationWeatherRepository {
  Future<void> getCurrentLocationWeather();
}

class CurrentLocationWeatherRepositoryImpl
    implements CurrentLocationWeatherRepository {
  final CurrentLocationWeatherLocalDataSource localDataSource = GetIt.I();
  final CurrentLocationWeatherRemoteDataSource remoteDataSource = GetIt.I();

  @override
  Future<void> getCurrentLocationWeather() async {
    // TODO(0xfbravo): implement
    return;
  }
}
