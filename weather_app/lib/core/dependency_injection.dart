// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

// 🌎 Project imports:
import 'package:weather_app/core/data/local_datasource.dart';
import 'package:weather_app/core/data/remote_datasource.dart';
import 'package:weather_app/core/data/repository.dart';
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/core/domain/usecases/get_locations_usecase.dart';
import 'package:weather_app/core/domain/usecases/search_location_usecase.dart';
import 'package:weather_app/features/current_weather/dependency_injection.dart';
import 'package:weather_app/features/current_weather/domain/model/current_weather_model.dart';
import 'package:weather_app/features/forecast/dependency_injection.dart';
import 'package:weather_app/features/forecast/domain/model/forecast_model.dart';

Future<void> setupDependencyInjection({
  required bool isTest,
}) async {
  await CorePackage.setup(isTest: isTest);
  CurrentWeatherPackage.setup();
  ForecastPackage.setup();
}

class CorePackage {
  CorePackage._();

  static Future<void> setup({required bool isTest}) async {
    _setupLogger();
    await _setupHive(isTest: isTest);
    _setupDio();
    _setupData();
    _setupDomain();
  }

  static void _setupLogger() {
    GetIt.I.registerSingleton(
      Logger(
        printer: PrettyPrinter(
          methodCount: 2, // number of method calls to be displayed
          errorMethodCount:
              8, // number of method calls if stacktrace is provided
          lineLength: 120, // width of the output
          colors: true, // Colorful log messages
          printEmojis: true, // Print an emoji for each log message
          printTime: true, // Should each log print contain a timestamp
        ),
      ),
    );
  }

  static Future<void> _setupHive({required bool isTest}) async {
    if (!isTest) {
      await Hive.initFlutter('./hive');
    } else {
      Hive.init('./hive-tests');
    }
    Hive
      ..registerAdapter(LocationModelAdapter())
      ..registerAdapter(CurrentWeatherModelAdapter())
      ..registerAdapter(ForecastModelAdapter());
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
      ..registerFactory<GetLocationsUseCase>(
        GetLocationsUseCaseImpl.new,
      )
      ..registerFactory<SearchLocationUseCase>(
        SearchLocationUseCaseImpl.new,
      );
  }
}
