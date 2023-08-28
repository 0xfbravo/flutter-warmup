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
import 'package:weather_app/features/current_weather/data/remote_datasource.dart';
import 'package:weather_app/features/current_weather/domain/model/current_weather_model.dart';
import 'remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CurrentWeatherRemoteDataSource>()])
void main() {
  group('[Feature/Current Weather] Remote Datasource', () {
    group('getCurrentWeather', () {
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
        final mock = MockCurrentWeatherRemoteDataSource();
        when(mock.getCurrentWeather(location: mockLocation))
            .thenThrow(Exception('Something went wrong'));
        expect(
          () => mock.getCurrentWeather(location: mockLocation),
          throwsException,
        );
      });

      test('it should return a value', () {
        final mock = MockCurrentWeatherRemoteDataSource();
        when(mock.getCurrentWeather(location: mockLocation)).thenAnswer(
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
        mock.getCurrentWeather(location: mockLocation).then((value) {
          expect(value, isNotNull);
          expect(value.description, isNotEmpty);
        });
      });

      test('it should do a successful request', () async {
        await setupDependencyInjection(isTest: true);
        final datasource = GetIt.I<CurrentWeatherRemoteDataSource>();
        await datasource
            .getCurrentWeather(location: mockLocation)
            .then((value) {
          expect(value, isNotNull);
          expect(value.description, isNotEmpty);
        });
      });

      test('it should do an unsuccessful request', () async {
        await setupDependencyInjection(isTest: true);
        final datasource = GetIt.I<CurrentWeatherRemoteDataSource>();
        expect(
          () => datasource.getCurrentWeather(
            location: LocationModel(
              name: 'Abubleblé das Ideias',
              lat: double.maxFinite,
              lon: double.maxFinite,
            ),
          ),
          throwsException,
        );
      });
    });
  });
}
