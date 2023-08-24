import 'package:weather_app/core/domain/model/saved_location_model.dart';

abstract class CoreRemoteDataSource {
  Future<SavedLocationModel> searchLocation({
    required String query,
  });
}

class CoreRemoteDataSourceImpl implements CoreRemoteDataSource {
  @override
  Future<SavedLocationModel> searchLocation({
    required String query,
  }) async {
    // TODO(0xfbravo): Search location using OpenWeatherMap API
    // https://openweathermap.org/api/geocoding-api
    return SavedLocationModel(name: query, lat: 0, lon: 0);
  }
}
