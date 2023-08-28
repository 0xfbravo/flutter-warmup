// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:weather_app/core/domain/model/location_model.dart';

abstract class CoreRemoteDataSource {
  Future<LocationModel> searchLocation({
    required String query,
  });
}

class CoreRemoteDataSourceImpl implements CoreRemoteDataSource {
  @override
  Future<LocationModel> searchLocation({
    required String query,
  }) async {
    final dio = GetIt.I<Dio>();
    final path = dotenv.env['OPEN_WEATHER_GEOCODING_PATH'] ?? 'unknown';
    final response = await dio.get<List<dynamic>>(
      path,
      queryParameters: {
        'q': query,
        'limit': 1,
      },
    );

    final data = response.data;
    if (data == null || data.isEmpty) {
      throw Exception('No data found for query: $query');
    }

    return LocationModel(
      name: query,
      lat: data.first['lat']! as double,
      lon: data.first['lon']! as double,
    );
  }
}
