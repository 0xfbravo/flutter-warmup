import 'package:get_it/get_it.dart';
import 'package:weather_app/features/current_weather/data/local_datasource.dart';
import 'package:weather_app/features/current_weather/data/remote_datasource.dart';
import 'package:weather_app/features/current_weather/data/repository.dart';
import 'package:weather_app/features/current_weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:weather_app/features/current_weather/presentation/cubit.dart';

class CurrentWeatherPackage {
  CurrentWeatherPackage._();

  static void setup() {
    _setupData();
    _setupDomain();
    _setupPresentation();
  }

  static void _setupData() {
    GetIt.I
      ..registerFactory<CurrentWeatherLocalDataSource>(
        CurrentWeatherLocalDataSourceImpl.new,
      )
      ..registerFactory<CurrentWeatherRemoteDataSource>(
        CurrentWeatherRemoteDataSourceImpl.new,
      )
      ..registerFactory<CurrentWeatherRepository>(
        CurrentWeatherRepositoryImpl.new,
      );
  }

  static void _setupDomain() {
    GetIt.I.registerFactory<GetCurrentWeatherUseCase>(
      GetCurrentWeatherUseCaseImpl.new,
    );
  }

  static void _setupPresentation() {
    GetIt.I.registerFactory<CurrentWeatherCubit>(
      CurrentWeatherCubit.new,
    );
  }
}
