// 📦 Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

// 🌎 Project imports:
import 'package:weather_app/core/dependency_injection.dart';
import 'package:weather_app/core/domain/usecases/get_locations_usecase.dart';

void main() {
  group('[Core] Get Saved Locations Use Case', () {
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
      await setupDependencyInjection(isTest: true);
      final useCase = GetLocationsUseCaseImpl();
      await useCase().then((value) => expect(value, isEmpty));
    });
  });
}
