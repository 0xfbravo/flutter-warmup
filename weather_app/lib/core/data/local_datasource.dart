// 📦 Package imports:
import 'package:hive/hive.dart';

// 🌎 Project imports:
import 'package:weather_app/core/domain/model/saved_location_model.dart';

abstract class CoreLocalDataSource {
  Future<SavedLocationModel?> hasCachedLocation({
    required String query,
  });
  Future<List<SavedLocationModel>> getSavedLocations();
  Future<bool> saveLocation({
    required SavedLocationModel location,
  });
}

class CoreLocalDataSourceImpl implements CoreLocalDataSource {
  Future<Box<SavedLocationModel>> _getHiveBox() async {
    return Hive.openBox<SavedLocationModel>('saved_locations');
  }

  @override
  Future<SavedLocationModel?> hasCachedLocation({
    required String query,
  }) async {
    final hiveBox = await _getHiveBox();
    return hiveBox.get(query);
  }

  @override
  Future<List<SavedLocationModel>> getSavedLocations() async {
    final hiveBox = await _getHiveBox();
    return hiveBox.values.toList();
  }

  @override
  Future<bool> saveLocation({
    required SavedLocationModel location,
  }) async {
    final hiveBox = await _getHiveBox();
    await hiveBox.put(location.name, location);
    return true;
  }
}
