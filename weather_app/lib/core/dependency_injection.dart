// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

// 🌎 Project imports:
import 'package:weather_app/core/data/local_datasource.dart';
import 'package:weather_app/core/data/remote_datasource.dart';
import 'package:weather_app/core/data/repository.dart';
import 'package:weather_app/core/domain/model/saved_location_model.dart';
import 'package:weather_app/core/domain/usecases/get_saved_locations_usecase.dart';
import 'package:weather_app/core/domain/usecases/search_location_usecase.dart';
import 'package:weather_app/features/current_weather/dependency_injection.dart';
import 'package:weather_app/features/current_weather/domain/model/current_weather_model.dart';
import 'package:weather_app/features/forecast/dependency_injection.dart';

Future<void> setupDependencyInjection() async {
  await CorePackage.setup();
  CurrentWeatherPackage.setup();
  ForecastPackage.setup();
}

class CorePackage {
  CorePackage._();

  static Future<void> setup() async {
    await _setupHive();
    _setupDio();
    _setupData();
    _setupDomain();
  }

  static Future<void> _setupHive() async {
    Hive
      ..init('./hive')
      ..registerAdapter(SavedLocationModelAdapter())
      ..registerAdapter(CurrentWeatherModelAdapter());
  }

  static void _setupDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['OPEN_WEATHER_API_URL'] ?? 'unknown',
        queryParameters: {
          'appid': dotenv.env['OPEN_WEATHER_API_TOKEN'] ?? 'unknown',
        },
      ),
    );
    GetIt.I.registerFactory<Dio>(() => dio);
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
