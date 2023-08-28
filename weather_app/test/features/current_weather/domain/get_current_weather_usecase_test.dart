// 📦 Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

// 🌎 Project imports:
import 'package:weather_app/core/dependency_injection.dart';
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/features/current_weather/domain/usecases/get_current_weather_usecase.dart';

void main() {
  group('[Feature/Current Weather] Get Current Weather Use Case', () {
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

    test('it should return an error', () async {
      await setupDependencyInjection(isTest: true);
      final useCase = GetCurrentWeatherUseCaseImpl();

      expect(
        () => useCase(
          location: LocationModel(
            name: 'Abubleblé das ideias',
            lat: double.maxFinite,
            lon: double.maxFinite,
          ),
        ),
        throwsException,
      );
    });

    test(
      'it should return current weather',
      () async {
        await setupDependencyInjection(isTest: true);
        final useCase = GetCurrentWeatherUseCaseImpl();

        // From remote
        await useCase(
          location: LocationModel(
            name: 'Monte Carlo, Monaco',
            lat: 43.7402961,
            lon: 7.426559,
          ),
        ).then((value) {
          expect(value, isNotNull);
          expect(value.description, isNotEmpty);
        });

        // From cache
        await useCase(
          location: LocationModel(
            name: 'Monte Carlo, Monaco',
            lat: 43.7402961,
            lon: 7.426559,
          ),
        ).then((value) {
          expect(value, isNotNull);
          expect(value.description, isNotEmpty);
        });
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );
  });
}
