// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/data/local_datasource.dart';

// Project imports:
import 'package:weather_app/core/data/remote_datasource.dart';
import 'package:weather_app/core/data/repository.dart';
import 'package:weather_app/core/domain/model/saved_location_model.dart';

import 'local_datasource_test.mocks.dart';
import 'remote_datasource_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<CoreRepository>(),
])
void main() {
  group('[Core] Repository', () {
    final localDataSource = MockCoreLocalDataSource();
    final remoteDataSource = MockCoreRemoteDataSource();

    setUp(() {
      GetIt.I.reset();
    });

    group('getSavedLocations', () {
      test('it should return a empty list', () {
        when(localDataSource.getSavedLocations()).thenAnswer((_) async => []);
        GetIt.I.registerFactory<CoreLocalDataSource>(() => localDataSource);
        GetIt.I.registerFactory<CoreRemoteDataSource>(() => remoteDataSource);

        final mock = CoreRepositoryImpl();
        mock.getSavedLocations().then((value) => expect(value, isEmpty));
      });

      test('it should return an error', () {
        when(localDataSource.getSavedLocations())
            .thenThrow(Exception('Something went wrong'));
        GetIt.I.registerFactory<CoreLocalDataSource>(() => localDataSource);
        GetIt.I.registerFactory<CoreRemoteDataSource>(() => remoteDataSource);

        final mock = CoreRepositoryImpl();
        expect(mock.getSavedLocations, throwsException);
      });

      test('it should return a valid list', () {
        when(localDataSource.getSavedLocations()).thenAnswer(
          (_) async => [
            SavedLocationModel(name: 'Mock Location', lat: 0, lon: 0),
          ],
        );
        GetIt.I.registerFactory<CoreLocalDataSource>(() => localDataSource);
        GetIt.I.registerFactory<CoreRemoteDataSource>(() => remoteDataSource);

        final mock = CoreRepositoryImpl();
        mock.getSavedLocations().then((value) => expect(value, isNotEmpty));
      });
    });
  });
}
