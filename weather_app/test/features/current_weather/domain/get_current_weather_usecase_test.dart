// 📦 Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

// 🌎 Project imports:
import 'package:weather_app/core/dependency_injection.dart';
import 'package:weather_app/core/domain/model/saved_location_model.dart';
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
      await setupDependencyInjection();
      final useCase = GetCurrentWeatherUseCaseImpl();

      expect(
        () => useCase(
          savedLocationModel: SavedLocationModel(
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
        await setupDependencyInjection();
        final useCase = GetCurrentWeatherUseCaseImpl();

        // From remote
        await useCase(
          savedLocationModel: SavedLocationModel(
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
          savedLocationModel: SavedLocationModel(
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
