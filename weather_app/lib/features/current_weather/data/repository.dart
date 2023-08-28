// 📦 Package imports:
import 'package:get_it/get_it.dart';
import 'package:weather_app/core/domain/model/saved_location_model.dart';

// 🌎 Project imports:
import 'package:weather_app/features/current_weather/data/local_datasource.dart';
import 'package:weather_app/features/current_weather/data/remote_datasource.dart';
import 'package:weather_app/features/current_weather/domain/model/current_weather_model.dart';

abstract class CurrentWeatherRepository {
  Future<CurrentWeatherModel> getCurrentWeather({
    required SavedLocationModel savedLocationModel,
  });
}

class CurrentWeatherRepositoryImpl implements CurrentWeatherRepository {
  final CurrentWeatherLocalDataSource localDataSource = GetIt.I();
  final CurrentWeatherRemoteDataSource remoteDataSource = GetIt.I();

  @override
  Future<CurrentWeatherModel> getCurrentWeather({
    required SavedLocationModel savedLocationModel,
  }) async {
    final cachedWeather = await localDataSource.hasCachedWeather(
      savedLocationModel: savedLocationModel,
    );
    if (cachedWeather != null) {
      return cachedWeather;
    }

    final currentWeather = await remoteDataSource.getCurrentWeather(
      savedLocationModel: savedLocationModel,
    );
    await localDataSource.saveWeather(
      location: savedLocationModel,
      weather: currentWeather,
    );
    return currentWeather;
  }
}
