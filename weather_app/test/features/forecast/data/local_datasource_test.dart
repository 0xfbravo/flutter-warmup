// 📦 Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// 🌎 Project imports:
import 'package:weather_app/core/dependency_injection.dart';
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/features/forecast/data/local_datasource.dart';
import 'package:weather_app/features/forecast/domain/model/forecast_model.dart';
import 'local_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ForecastLocalDataSource>()])
void main() {
  group('[Feature/Forecast] Local Datasource', () {
    group('hasCached', () {
      final mockLocation = LocationModel(name: 'Mock Location', lat: 0, lon: 0);
      final mockForecast = [
        ForecastModel(
          date: DateTime.now().toIso8601String(),
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
      ];

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

      test('it should return nulll (no cached forecast)', () async {
        final mock = MockForecastLocalDataSource();
        when(mock.hasCached(location: mockLocation))
            .thenAnswer((_) async => null);
        await mock
            .hasCached(location: mockLocation)
            .then((value) => expect(value, isNull));

        await setupDependencyInjection();
        final datasource = GetIt.I<ForecastLocalDataSource>();
        await datasource
            .hasCached(location: mockLocation)
            .then((value) => expect(value, isNull));
      });

      test('it should return an error', () {
        final mock = MockForecastLocalDataSource();
        when(mock.hasCached(location: mockLocation))
            .thenThrow(Exception('Something went wrong'));
        expect(
          () => mock.hasCached(location: mockLocation),
          throwsException,
        );
      });

      test('it should return a cached forecast', () {
        final mock = MockForecastLocalDataSource();
        when(mock.hasCached(location: mockLocation))
            .thenAnswer((_) async => mockForecast);
        mock.hasCached(location: mockLocation).then((value) {
          expect(value, isNotNull);
          expect(value!.length, 1);
        });
      });
    });

    group('getSavedForecasts', () {
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

      test('it should return a empty list', () async {
        final mock = MockForecastLocalDataSource();
        when(mock.getSavedForecasts()).thenAnswer((_) async => []);
        await mock.getSavedForecasts().then((value) => expect(value, isEmpty));

        await setupDependencyInjection();
        final datasource = GetIt.I<ForecastLocalDataSource>();
        await datasource
            .getSavedForecasts()
            .then((value) => expect(value, isEmpty));
      });

      test('it should return an error', () {
        final mock = MockForecastLocalDataSource();
        when(mock.getSavedForecasts())
            .thenThrow(Exception('Something went wrong'));
        expect(mock.getSavedForecasts, throwsException);
      });

      test('it should return a valid list', () {
        final mock = MockForecastLocalDataSource();
        when(mock.getSavedForecasts()).thenAnswer(
          (_) async => [
            [
              ForecastModel(
                date: DateTime.now().toIso8601String(),
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
            ],
            [
              ForecastModel(
                date: DateTime.now().toIso8601String(),
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
            ]
          ],
        );
        mock.getSavedForecasts().then((value) => expect(value, isNotEmpty));
      });
    });

    group('saveForecast', () {
      final mockLocation = LocationModel(name: 'Mock Location', lat: 0, lon: 0);
      final mockForecast = [
        ForecastModel(
          date: DateTime.now().toIso8601String(),
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
      ];

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

      test('it should save a forecast', () async {
        final mock = MockForecastLocalDataSource();
        when(mock.saveForecast(location: mockLocation, forecast: mockForecast))
            .thenAnswer((_) async => true);
        await mock
            .saveForecast(location: mockLocation, forecast: mockForecast)
            .then((value) => expect(value, isTrue));

        await setupDependencyInjection();
        final datasource = GetIt.I<ForecastLocalDataSource>();
        await datasource
            .saveForecast(location: mockLocation, forecast: mockForecast)
            .then((value) => expect(value, isTrue));
      });

      test('it should return an error', () {
        final mock = MockForecastLocalDataSource();
        when(mock.saveForecast(location: mockLocation, forecast: mockForecast))
            .thenThrow(Exception('Something went wrong'));
        expect(
          () =>
              mock.saveForecast(location: mockLocation, forecast: mockForecast),
          throwsException,
        );
      });

      test('it should return false (unable to save forecast)', () {
        final mock = MockForecastLocalDataSource();
        when(mock.saveForecast(location: mockLocation, forecast: mockForecast))
            .thenAnswer(
          (_) async => false,
        );
        mock.saveForecast(location: mockLocation, forecast: mockForecast).then(
              (value) => expect(
                value,
                isFalse,
              ),
            );
      });
    });
  });
}
