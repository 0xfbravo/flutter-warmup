import 'package:get_it/get_it.dart';
import 'package:weather_app/features/current_location/data/local_datasource.dart';
import 'package:weather_app/features/current_location/data/remote_datasource.dart';
import 'package:weather_app/features/current_location/data/repository.dart';
import 'package:weather_app/features/current_location/domain/usecases/get_current_location_weather_usecase.dart';
import 'package:weather_app/features/current_location/presentation/cubit.dart';

class CurrentLocationWeatherPackage {
  CurrentLocationWeatherPackage._();

  static void setup() {
    _setupData();
    _setupDomain();
    _setupPresentation();
  }

  static void _setupData() {
    GetIt.I
      ..registerFactory<CurrentLocationWeatherLocalDataSource>(
        CurrentLocationWeatherLocalDataSourceImpl.new,
      )
      ..registerFactory<CurrentLocationWeatherRemoteDataSource>(
        CurrentLocationWeatherRemoteDataSourceImpl.new,
      )
      ..registerFactory<CurrentLocationWeatherRepository>(
        CurrentLocationWeatherRepositoryImpl.new,
      );
  }

  static void _setupDomain() {
    GetIt.I.registerFactory<GetCurrentLocationWeatherUseCase>(
      GetCurrentLocationWeatherUseCaseImpl.new,
    );
  }

  static void _setupPresentation() {
    GetIt.I.registerFactory<CurrentLocationWeatherCubit>(
      CurrentLocationWeatherCubit.new,
    );
  }
}
