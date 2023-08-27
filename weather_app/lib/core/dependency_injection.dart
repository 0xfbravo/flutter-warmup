// 📦 Package imports:
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:weather_app/core/data/local_datasource.dart';
import 'package:weather_app/core/data/remote_datasource.dart';
import 'package:weather_app/core/data/repository.dart';
import 'package:weather_app/core/domain/usecases/get_saved_locations_usecase.dart';
import 'package:weather_app/core/domain/usecases/search_location_usecase.dart';
import 'package:weather_app/features/current_weather/dependency_injection.dart';
import 'package:weather_app/features/saved_location_forecast/dependency_injection.dart';

void setupDependencyInjection() {
  CorePackage.setup();
  CurrentWeatherPackage.setup();
  SavedLocationForecastPackage.setup();
}

class CorePackage {
  CorePackage._();

  static void setup() {
    _setupData();
    _setupDomain();
  }

  static void _setupData() {
    GetIt.I
      ..registerFactory<CoreLocalDataSource>(
        CoreLocalDataSourceImpl.new,
      )
      ..registerFactory<CoreRemoteDataSource>(
        CoreRemoteDataSourceImpl.new,
      )
      ..registerFactory<CoreRepository>(
        CoreRepositoryImpl.new,
      );
  }

  static void _setupDomain() {
    GetIt.I
      ..registerFactory<GetSavedLocationsUseCase>(
        GetSavedLocationsUseCaseImpl.new,
      )
      ..registerFactory<SearchLocationUseCase>(
        SearchLocationUseCaseImpl.new,
      );
  }
}
