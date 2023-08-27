// 📦 Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// 🌎 Project imports:
import 'package:weather_app/core/data/remote_datasource.dart';
import 'package:weather_app/core/dependency_injection.dart';
import 'package:weather_app/core/domain/model/saved_location_model.dart';
import 'remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CoreRemoteDataSource>()])
void main() {
  group('[Core] Remote Datasource', () {
    group('searchLocation', () {
      const query = 'Mock Location, Mock';

      tearDown(() {
        GetIt.I.reset();
      });

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

      test('it should return do a successful request', () async {
        await dotenv.load(fileName: '.env');
        setupDependencyInjection();
        final datasource = GetIt.I<CoreRemoteDataSource>();
        await datasource
            .searchLocation(query: 'Monte Carlo, Monaco')
            .then((value) {
          expect(value, isNotNull);
          expect(value.name.isNotEmpty, isTrue);
        });
      });

      test('it should return do an unsuccessful request', () async {
        await dotenv.load(fileName: '.env');
        setupDependencyInjection();
        final datasource = GetIt.I<CoreRemoteDataSource>();
        expect(
          () => datasource.searchLocation(query: 'Abubleblé, Das Ideias'),
          throwsException,
        );
      });
    });
  });
}
