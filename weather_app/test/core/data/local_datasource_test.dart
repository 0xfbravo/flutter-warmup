// 📦 Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// 🌎 Project imports:
import 'package:weather_app/core/data/local_datasource.dart';
import 'package:weather_app/core/dependency_injection.dart';
import 'package:weather_app/core/domain/model/location_model.dart';
import 'local_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CoreLocalDataSource>()])
void main() {
  group('[Core] Local Datasource', () {
    group('hasCached', () {
      const query = 'Mock Location, Mock';

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

      test('it should return nulll (no cached location)', () async {
        final mock = MockCoreLocalDataSource();
        when(mock.hasCached(query: query)).thenAnswer((_) async => null);
        await mock
            .hasCached(query: query)
            .then((value) => expect(value, isNull));

        await setupDependencyInjection(isTest: true);
        final datasource = GetIt.I<CoreLocalDataSource>();
        await datasource
            .hasCached(query: 'Abubleblé, Das Ideias')
            .then((value) => expect(value, isNull));
      });

      test('it should return an error', () {
        final mock = MockCoreLocalDataSource();
        when(mock.hasCached(query: query))
            .thenThrow(Exception('Something went wrong'));
        expect(() => mock.hasCached(query: query), throwsException);
      });

      test('it should return a cached location', () {
        final mock = MockCoreLocalDataSource();
        when(mock.hasCached(query: query)).thenAnswer(
          (_) async => LocationModel(name: 'Mock Location', lat: 0, lon: 0),
        );
        mock.hasCached(query: query).then((value) {
          expect(value, isNotNull);
          expect(value!.name.isNotEmpty, isTrue);
        });
      });
    });

    group('getLocations', () {
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
        final mock = MockCoreLocalDataSource();
        when(mock.getLocations()).thenAnswer((_) async => []);
        await mock.getLocations().then((value) => expect(value, isEmpty));

        await setupDependencyInjection(isTest: true);
        final datasource = GetIt.I<CoreLocalDataSource>();
        await datasource.getLocations().then((value) => expect(value, isEmpty));
      });

      test('it should return an error', () {
        final mock = MockCoreLocalDataSource();
        when(mock.getLocations()).thenThrow(Exception('Something went wrong'));
        expect(mock.getLocations, throwsException);
      });

      test('it should return a valid list', () {
        final mock = MockCoreLocalDataSource();
        when(mock.getLocations()).thenAnswer(
          (_) async => [
            LocationModel(name: 'Mock Location', lat: 0, lon: 0),
          ],
        );
        mock.getLocations().then((value) => expect(value, isNotEmpty));
      });
    });

    group('saveLocation', () {
      final mockLocation = LocationModel(name: 'Mock Location', lat: 0, lon: 0);

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

      test('it should save a location', () async {
        final mock = MockCoreLocalDataSource();
        when(mock.saveLocation(location: mockLocation))
            .thenAnswer((_) async => true);
        await mock
            .saveLocation(location: mockLocation)
            .then((value) => expect(value, isTrue));

        await setupDependencyInjection(isTest: true);
        final datasource = GetIt.I<CoreLocalDataSource>();
        await datasource
            .saveLocation(location: mockLocation)
            .then((value) => expect(value, isTrue));
      });

      test('it should return an error', () {
        final mock = MockCoreLocalDataSource();
        when(mock.saveLocation(location: mockLocation))
            .thenThrow(Exception('Something went wrong'));
        expect(
          () => mock.saveLocation(location: mockLocation),
          throwsException,
        );
      });

      test('it should return false (unable to save location)', () {
        final mock = MockCoreLocalDataSource();
        when(mock.saveLocation(location: mockLocation)).thenAnswer(
          (_) async => false,
        );
        mock.saveLocation(location: mockLocation).then(
              (value) => expect(
                value,
                isFalse,
              ),
            );
      });
    });
  });
}
