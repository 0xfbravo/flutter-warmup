// 📦 Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// 🌎 Project imports:
import 'package:weather_app/core/dependency_injection.dart';
import 'package:weather_app/core/domain/model/saved_location_model.dart';
import 'package:weather_app/features/current_weather/data/local_datasource.dart';
import 'package:weather_app/features/current_weather/domain/model/current_weather_model.dart';
import 'local_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CurrentWeatherLocalDataSource>()])
void main() {
  group('[Feature/Current Weather] Local Datasource', () {
    group('hasCachedWeather', () {
      final mockLocation =
          SavedLocationModel(name: 'Mock Location', lat: 0, lon: 0);
      final mockWeather = CurrentWeatherModel(
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

      test('it should return nulll (no cached weather)', () async {
        final mock = MockCurrentWeatherLocalDataSource();
        when(mock.hasCachedWeather(savedLocationModel: mockLocation))
            .thenAnswer((_) async => null);
        await mock
            .hasCachedWeather(savedLocationModel: mockLocation)
            .then((value) => expect(value, isNull));

        await setupDependencyInjection();
        final datasource = GetIt.I<CurrentWeatherLocalDataSource>();
        await datasource
            .hasCachedWeather(savedLocationModel: mockLocation)
            .then((value) => expect(value, isNull));
      });

      test('it should return an error', () {
        final mock = MockCurrentWeatherLocalDataSource();
        when(mock.hasCachedWeather(savedLocationModel: mockLocation))
            .thenThrow(Exception('Something went wrong'));
        expect(
          () => mock.hasCachedWeather(savedLocationModel: mockLocation),
          throwsException,
        );
      });

      test('it should return a cached weather', () {
        final mock = MockCurrentWeatherLocalDataSource();
        when(mock.hasCachedWeather(savedLocationModel: mockLocation))
            .thenAnswer((_) async => mockWeather);
        mock.hasCachedWeather(savedLocationModel: mockLocation).then((value) {
          expect(value, isNotNull);
          expect(value!.description, isNotEmpty);
        });
      });
    });

    group('getSavedWeathers', () {
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
        final mock = MockCurrentWeatherLocalDataSource();
        when(mock.getSavedWeathers()).thenAnswer((_) async => []);
        await mock.getSavedWeathers().then((value) => expect(value, isEmpty));

        await setupDependencyInjection();
        final datasource = GetIt.I<CurrentWeatherLocalDataSource>();
        await datasource
            .getSavedWeathers()
            .then((value) => expect(value, isEmpty));
      });

      test('it should return an error', () {
        final mock = MockCurrentWeatherLocalDataSource();
        when(mock.getSavedWeathers())
            .thenThrow(Exception('Something went wrong'));
        expect(mock.getSavedWeathers, throwsException);
      });

      test('it should return a valid list', () {
        final mock = MockCurrentWeatherLocalDataSource();
        when(mock.getSavedWeathers()).thenAnswer(
          (_) async => [
            CurrentWeatherModel(
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
        );
        mock.getSavedWeathers().then((value) => expect(value, isNotEmpty));
      });
    });

    group('saveWeather', () {
      final mockLocation =
          SavedLocationModel(name: 'Mock Location', lat: 0, lon: 0);
      final mockWeather = CurrentWeatherModel(
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

      test('it should save a weather', () async {
        final mock = MockCurrentWeatherLocalDataSource();
        when(mock.saveWeather(location: mockLocation, weather: mockWeather))
            .thenAnswer((_) async => true);
        await mock
            .saveWeather(location: mockLocation, weather: mockWeather)
            .then((value) => expect(value, isTrue));

        await setupDependencyInjection();
        final datasource = GetIt.I<CurrentWeatherLocalDataSource>();
        await datasource
            .saveWeather(location: mockLocation, weather: mockWeather)
            .then((value) => expect(value, isTrue));
      });

      test('it should return an error', () {
        final mock = MockCurrentWeatherLocalDataSource();
        when(mock.saveWeather(location: mockLocation, weather: mockWeather))
            .thenThrow(Exception('Something went wrong'));
        expect(
          () => mock.saveWeather(location: mockLocation, weather: mockWeather),
          throwsException,
        );
      });

      test('it should return false (unable to save weather)', () {
        final mock = MockCurrentWeatherLocalDataSource();
        when(mock.saveWeather(location: mockLocation, weather: mockWeather))
            .thenAnswer(
          (_) async => false,
        );
        mock.saveWeather(location: mockLocation, weather: mockWeather).then(
              (value) => expect(
                value,
                isFalse,
              ),
            );
      });
    });
  });
}
