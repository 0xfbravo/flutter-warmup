// 📦 Package imports:
import 'package:hive/hive.dart';

// 🌎 Project imports:
import 'package:weather_app/core/domain/model/location_model.dart';

abstract class CoreLocalDataSource {
  Future<LocationModel?> hasCached({
    required String query,
  });
  Future<List<LocationModel>> getSavedLocations();
  Future<bool> saveLocation({
    required LocationModel location,
  });
}

class CoreLocalDataSourceImpl implements CoreLocalDataSource {
  Future<Box<LocationModel>> _getHiveBox() async {
    return Hive.openBox<LocationModel>('saved_locations');
  }

  @override
  Future<LocationModel?> hasCached({
    required String query,
  }) async {
    final hiveBox = await _getHiveBox();
    return hiveBox.get(query);
  }

  @override
  Future<List<LocationModel>> getSavedLocations() async {
    final hiveBox = await _getHiveBox();
    return hiveBox.values.toList();
  }

  @override
  Future<bool> saveLocation({
    required LocationModel location,
  }) async {
    final hiveBox = await _getHiveBox();
    await hiveBox.put(location.name, location);
    return true;
  }
}
