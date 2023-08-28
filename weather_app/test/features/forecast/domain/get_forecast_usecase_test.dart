// 📦 Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

// 🌎 Project imports:
import 'package:weather_app/core/dependency_injection.dart';
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/features/forecast/domain/usecases/get_forecast_usecase.dart';

void main() {
  group('[Feature/Forecast] Get Forecast Use Case', () {
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
      final useCase = GetForecastUseCaseImpl();

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
      'it should return forecast',
      () async {
        await setupDependencyInjection(isTest: true);
        final useCase = GetForecastUseCaseImpl();

        // From remote
        await useCase(
          location: LocationModel(
            name: 'Monte Carlo, Monaco',
            lat: 43.7402961,
            lon: 7.426559,
          ),
        ).then((value) {
          expect(value, isNotNull);
          expect(value.length, greaterThan(1));
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
          expect(value.length, greaterThan(1));
        });
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );
  });
}
