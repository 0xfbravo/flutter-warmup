// 📦 Package imports:
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/features/current_weather/data/local_datasource.dart';
import 'package:weather_app/features/current_weather/data/remote_datasource.dart';
import 'package:weather_app/features/current_weather/domain/model/current_weather_model.dart';

abstract class CurrentWeatherRepository {
  Future<CurrentWeatherModel> getCurrentWeather({
    required LocationModel location,
  });
}

class CurrentWeatherRepositoryImpl implements CurrentWeatherRepository {
  final CurrentWeatherLocalDataSource localDataSource = GetIt.I();
  final CurrentWeatherRemoteDataSource remoteDataSource = GetIt.I();

  @override
  Future<CurrentWeatherModel> getCurrentWeather({
    required LocationModel location,
  }) async {
    final cachedWeather = await localDataSource.hasCachedWeather(
      location: location,
    );
    if (cachedWeather != null) {
      return cachedWeather;
    }

    final currentWeather = await remoteDataSource.getCurrentWeather(
      location: location,
    );
    await localDataSource.saveWeather(
      location: location,
      weather: currentWeather,
    );
    return currentWeather;
  }
}
