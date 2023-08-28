// 📦 Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// 🌎 Project imports:
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/features/forecast/data/local_datasource.dart';
import 'package:weather_app/features/forecast/data/remote_datasource.dart';
import 'package:weather_app/features/forecast/data/repository.dart';
import 'package:weather_app/features/forecast/domain/model/forecast_model.dart';
import 'local_datasource_test.mocks.dart';
import 'remote_datasource_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ForecastRepository>(),
])
void main() {
  final localDataSource = MockForecastLocalDataSource();
  final remoteDataSource = MockForecastRemoteDataSource();

  group('[Feature/Forecast] Repository', () {
    group('getForecast', () {
      final mockLocation = LocationModel(
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
        when(
          remoteDataSource.getForecast(
            location: mockLocation,
          ),
        ).thenThrow(Exception('Something went wrong'));
        GetIt.I.registerFactory<ForecastLocalDataSource>(
          () => localDataSource,
        );
        GetIt.I.registerFactory<ForecastRemoteDataSource>(
          () => remoteDataSource,
        );

        final repository = ForecastRepositoryImpl();
        expect(
          () => repository.getForecast(location: mockLocation),
          throwsException,
        );
      });

      test('it should return a value from server', () {
        when(
          remoteDataSource.getForecast(
            location: mockLocation,
          ),
        ).thenAnswer(
          (_) async => [
            ForecastModel(
              date: DateTime.now().toIso8601String(),
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
          ],
        );
        GetIt.I.registerFactory<ForecastLocalDataSource>(
          () => localDataSource,
        );
        GetIt.I.registerFactory<ForecastRemoteDataSource>(
          () => remoteDataSource,
        );

        final repository = ForecastRepositoryImpl();
        repository.getForecast(location: mockLocation).then((value) {
          expect(value, isNotNull);
          expect(value.length, 1);
        });
      });

      test('it should return a value from cache', () {
        when(
          localDataSource.hasCached(
            location: mockLocation,
          ),
        ).thenAnswer(
          (_) async => [
            ForecastModel(
              date: DateTime.now().toIso8601String(),
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
          ],
        );
        GetIt.I.registerFactory<ForecastLocalDataSource>(
          () => localDataSource,
        );
        GetIt.I.registerFactory<ForecastRemoteDataSource>(
          () => remoteDataSource,
        );

        final repository = ForecastRepositoryImpl();
        repository.getForecast(location: mockLocation).then((value) {
          expect(value, isNotNull);
          expect(value.length, 1);
        });
      });
    });
  });
}
