// 📦 Package imports:
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/features/forecast/data/local_datasource.dart';
import 'package:weather_app/features/forecast/data/remote_datasource.dart';
import 'package:weather_app/features/forecast/domain/model/forecast_model.dart';

abstract class ForecastRepository {
  Future<List<ForecastModel>> getForecast({
    required LocationModel location,
  });
}

class ForecastRepositoryImpl implements ForecastRepository {
  final ForecastLocalDataSource localDataSource = GetIt.I();
  final ForecastRemoteDataSource remoteDataSource = GetIt.I();

  @override
  Future<List<ForecastModel>> getForecast({
    required LocationModel location,
  }) async {
    final cachedForecast = await localDataSource.hasCached(
      location: location,
    );
    if (cachedForecast != null) {
      return cachedForecast;
    }

    final forecast = await remoteDataSource.getForecast(
      location: location,
    );
    await localDataSource.saveForecast(
      location: location,
      forecast: forecast,
    );
    return forecast;
  }
}
