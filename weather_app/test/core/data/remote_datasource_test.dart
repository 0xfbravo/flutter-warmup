// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:weather_app/core/data/remote_datasource.dart';
import 'package:weather_app/core/domain/model/saved_location_model.dart';
import 'remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CoreRemoteDataSource>()])
void main() {
  group('[Core] Remote Datasource', () {
    group('searchLocation', () {
      const query = 'Mock Location, Mock';

      test('it should return an error', () {
        final mock = MockCoreRemoteDataSource();
        when(mock.searchLocation(query: query))
            .thenThrow(Exception('Something went wrong'));
        expect(() => mock.searchLocation(query: query), throwsException);
      });

      test('it should return a value', () {
        final mock = MockCoreRemoteDataSource();
        when(mock.searchLocation(query: query)).thenAnswer(
          (_) async =>
              SavedLocationModel(name: 'Mock Location', lat: 0, lon: 0),
        );
        mock.searchLocation(query: query).then((value) {
          expect(value, isNotNull);
          expect(value.name.isNotEmpty, isTrue);
        });
      });
    });
  });
}
