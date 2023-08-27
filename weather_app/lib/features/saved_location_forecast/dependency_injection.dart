// 📦 Package imports:
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:weather_app/features/saved_location_forecast/data/local_datasource.dart';
import 'package:weather_app/features/saved_location_forecast/data/remote_datasource.dart';
import 'package:weather_app/features/saved_location_forecast/data/repository.dart';
import 'package:weather_app/features/saved_location_forecast/domain/usecases/get_saved_location_forecast_usecase.dart';
import 'package:weather_app/features/saved_location_forecast/presentation/cubit.dart';

class SavedLocationForecastPackage {
  SavedLocationForecastPackage._();

  static void setup() {
    _setupData();
    _setupDomain();
    _setupPresentation();
  }

  static void _setupData() {
    GetIt.I
      ..registerFactory<SavedLocationForecastLocalDataSource>(
        SavedLocationForecastLocalDataSourceImpl.new,
      )
      ..registerFactory<SavedLocationForecastRemoteDataSource>(
        SavedLocationForecastRemoteDataSourceImpl.new,
      )
      ..registerFactory<SavedLocationForecastRepository>(
        SavedLocationForecastRepositoryImpl.new,
      );
  }

  static void _setupDomain() {
    GetIt.I.registerFactory<GetSavedLocationForecastUseCase>(
      GetSavedLocationForecastUseCaseImpl.new,
    );
  }

  static void _setupPresentation() {
    GetIt.I.registerFactory<SavedLocationForecastCubit>(
      SavedLocationForecastCubit.new,
    );
  }
}
