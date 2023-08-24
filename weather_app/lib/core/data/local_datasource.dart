// Project imports:
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
  @override
  Future<SavedLocationModel?> hasCachedLocation({
    required String query,
  }) async {
    // TODO(0xfbravo): implement
    return null;
  }

  @override
  Future<List<SavedLocationModel>> getSavedLocations() async {
    // TODO(0xfbravo): Get saved locations from local storage
    return [
      SavedLocationModel(name: 'Silverstone, UK', lat: 0, lon: 0),
      SavedLocationModel(name: 'São Paulo, Brazil', lat: 0, lon: 0),
      SavedLocationModel(name: 'Melbourne, Australia', lat: 0, lon: 0),
      SavedLocationModel(name: 'Monte Carlo, Monaco', lat: 0, lon: 0),
    ];
  }

  @override
  Future<bool> saveLocation({
    required SavedLocationModel location,
  }) async {
    // TODO(0xfbravo): implement
    return true;
  }
}
