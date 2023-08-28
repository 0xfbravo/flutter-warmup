// 📦 Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// 🌎 Project imports:
import 'package:weather_app/core/domain/model/saved_location_model.dart';
import 'package:weather_app/features/current_weather/data/local_datasource.dart';
import 'package:weather_app/features/current_weather/data/remote_datasource.dart';
import 'package:weather_app/features/current_weather/data/repository.dart';
import 'package:weather_app/features/current_weather/domain/model/current_weather_model.dart';
import 'local_datasource_test.mocks.dart';
import 'remote_datasource_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<CurrentWeatherRepository>(),
])
void main() {
  final localDataSource = MockCurrentWeatherLocalDataSource();
  final remoteDataSource = MockCurrentWeatherRemoteDataSource();

  group('[Feature/Current Weather] Repository', () {
    group('getCurrentWeather', () {
      final mockLocation = SavedLocationModel(
        name: 'Monte Carlo, Monaco',
        lat: 43.7402961,
        lon: 7.426559,
      );

      setUp(() async {
        await dotenv.load(fileName: '.env');
        Hive.init('./hive-tests');
      });

      tearDown(() async {
        Hive.resetAdapters();
        await Hive.deleteFromDisk();
        await GetIt.I.reset();
        dotenv.clean();
      });

      test('it should return an error', () {
        when(remoteDataSource.getCurrentWeather(
                savedLocationModel: mockLocation))
            .thenThrow(Exception('Something went wrong'));
        GetIt.I.registerFactory<CurrentWeatherLocalDataSource>(
          () => localDataSource,
        );
        GetIt.I.registerFactory<CurrentWeatherRemoteDataSource>(
          () => remoteDataSource,
        );

        final repository = CurrentWeatherRepositoryImpl();
        expect(
          () => repository.getCurrentWeather(savedLocationModel: mockLocation),
          throwsException,
        );
      });

      test('it should return a value from server', () {
        when(
          remoteDataSource.getCurrentWeather(
            savedLocationModel: mockLocation,
          ),
        ).thenAnswer(
          (_) async => CurrentWeatherModel(
            latitude: 0,
            longitude: 0,
            main: 'AAAA',
            description: 'AAAA',
            icon: 'AAA',
            temperature: 0,
            feelsLike: 0,
            minTemperature: 0,
            maxTemperature: 0,
            pressure: 0,
            humidity: 0,
            seaLevel: 0,
            groundLevel: 0,
          ),
        );
        GetIt.I.registerFactory<CurrentWeatherLocalDataSource>(
          () => localDataSource,
        );
        GetIt.I.registerFactory<CurrentWeatherRemoteDataSource>(
          () => remoteDataSource,
        );

        final repository = CurrentWeatherRepositoryImpl();
        repository
            .getCurrentWeather(savedLocationModel: mockLocation)
            .then((value) {
          expect(value, isNotNull);
          expect(value.description, isNotEmpty);
        });
      });

      test('it should return a value from cache', () {
        when(
          localDataSource.hasCachedWeather(
            savedLocationModel: mockLocation,
          ),
        ).thenAnswer(
          (_) async => CurrentWeatherModel(
            latitude: 0,
            longitude: 0,
            main: 'AAAA',
            description: 'AAAA',
            icon: 'AAA',
            temperature: 0,
            feelsLike: 0,
            minTemperature: 0,
            maxTemperature: 0,
            pressure: 0,
            humidity: 0,
            seaLevel: 0,
            groundLevel: 0,
          ),
        );
        GetIt.I.registerFactory<CurrentWeatherLocalDataSource>(
          () => localDataSource,
        );
        GetIt.I.registerFactory<CurrentWeatherRemoteDataSource>(
          () => remoteDataSource,
        );

        final repository = CurrentWeatherRepositoryImpl();
        repository
            .getCurrentWeather(savedLocationModel: mockLocation)
            .then((value) {
          expect(value, isNotNull);
          expect(value.description, isNotEmpty);
        });
      });
    });
  });
}
