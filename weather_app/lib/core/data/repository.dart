// 📦 Package imports:
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:weather_app/core/data/local_datasource.dart';
import 'package:weather_app/core/data/remote_datasource.dart';
import 'package:weather_app/core/domain/model/location_model.dart';

abstract class CoreRepository {
  Future<List<LocationModel>> getSavedLocations();
  Future<LocationModel> searchLocation({
    required String query,
  });
}

class CoreRepositoryImpl implements CoreRepository {
  final CoreLocalDataSource _localDataSource = GetIt.I();
  final CoreRemoteDataSource _remoteDataSource = GetIt.I();

  @override
  Future<List<LocationModel>> getSavedLocations() async {
    return _localDataSource.getSavedLocations();
  }

  @override
  Future<LocationModel> searchLocation({
    required String query,
  }) async {
    final cachedLocation = await _localDataSource.hasCached(query: query);
    if (cachedLocation != null) {
      return cachedLocation;
    }

    final location = await _remoteDataSource.searchLocation(query: query);
    await _localDataSource.saveLocation(location: location);
    return location;
  }
}
