// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:weather_app/features/saved_location_forecast/data/local_datasource.dart';
import 'package:weather_app/features/saved_location_forecast/data/remote_datasource.dart';

abstract class SavedLocationForecastRepository {
  Future<void> getSavedLocationForecast();
}

class SavedLocationForecastRepositoryImpl
    implements SavedLocationForecastRepository {
  final SavedLocationForecastLocalDataSource localDataSource = GetIt.I();
  final SavedLocationForecastRemoteDataSource remoteDataSource = GetIt.I();

  @override
  Future<void> getSavedLocationForecast() async {
    // TODO(0xfbravo): implement
    return;
  }
}
