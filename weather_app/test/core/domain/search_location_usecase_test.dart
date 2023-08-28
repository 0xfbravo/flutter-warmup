// 📦 Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

// 🌎 Project imports:
import 'package:weather_app/core/data/repository.dart';
import 'package:weather_app/core/dependency_injection.dart';

void main() {
  group('[Core] Search Location Use Case', () {
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

    test('it should return a value from server', () async {
      await setupDependencyInjection();
      final mock = CoreRepositoryImpl();
      await mock.searchLocation(query: 'São Paulo, Brazil').then((value) {
        expect(value, isNotNull);
        expect(value.name.isNotEmpty, isTrue);
      });
    });
  });
}
