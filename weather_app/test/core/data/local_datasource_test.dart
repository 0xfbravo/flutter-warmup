import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/domain/model/saved_location_model.dart';
import 'local_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CoreLocalDataSource>()])
import 'package:weather_app/core/data/local_datasource.dart';

void main() {
  group('[Core] Local Datasource', () {
    group('hasCachedLocation', () {
      const query = 'Mock Location, Mock';

      test('it should return nulll (no cached location)', () {
        final mock = MockCoreLocalDataSource();
        when(mock.hasCachedLocation(query: query))
            .thenAnswer((_) async => null);
        mock
            .hasCachedLocation(query: query)
            .then((value) => expect(value, isNull));
      });

      test('it should return an error', () {
        final mock = MockCoreLocalDataSource();
        when(mock.hasCachedLocation(query: query))
            .thenThrow(Exception('Something went wrong'));
        expect(() => mock.hasCachedLocation(query: query), throwsException);
      });

      test('it should return a cached location', () {
        final mock = MockCoreLocalDataSource();
        when(mock.hasCachedLocation(query: query)).thenAnswer(
          (_) async =>
              SavedLocationModel(name: 'Mock Location', lat: 0, lon: 0),
        );
        mock.hasCachedLocation(query: query).then((value) {
          expect(value, isNotNull);
          expect(value!.name.isNotEmpty, isTrue);
        });
      });
    });

    group('getSavedLocations', () {
      test('it should return a empty list', () {
        final mock = MockCoreLocalDataSource();
        when(mock.getSavedLocations()).thenAnswer((_) async => []);
        mock.getSavedLocations().then((value) => expect(value, isEmpty));
      });

      test('it should return an error', () {
        final mock = MockCoreLocalDataSource();
        when(mock.getSavedLocations())
            .thenThrow(Exception('Something went wrong'));
        expect(mock.getSavedLocations, throwsException);
      });

      test('it should return a valid list', () {
        final mock = MockCoreLocalDataSource();
        when(mock.getSavedLocations()).thenAnswer(
          (_) async => [
            SavedLocationModel(name: 'Mock Location', lat: 0, lon: 0),
          ],
        );
        mock.getSavedLocations().then((value) => expect(value, isNotEmpty));
      });
    });

    group('saveLocation', () {
      final mockLocation =
          SavedLocationModel(name: 'Mock Location', lat: 0, lon: 0);

      test('it should save a location', () {
        final mock = MockCoreLocalDataSource();
        when(mock.saveLocation(location: mockLocation))
            .thenAnswer((_) async => true);
        mock
            .saveLocation(location: mockLocation)
            .then((value) => expect(value, isTrue));
      });

      test('it should return an error', () {
        final mock = MockCoreLocalDataSource();
        when(mock.saveLocation(location: mockLocation))
            .thenThrow(Exception('Something went wrong'));
        expect(
            () => mock.saveLocation(location: mockLocation), throwsException);
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
