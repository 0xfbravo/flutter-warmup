// 🌎 Project imports:
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/features/forecast/domain/model/forecast_model.dart';

abstract class ForecastRemoteDataSource {
  Future<List<ForecastModel>> getForecast({
    required LocationModel location,
  });
}

class ForecastRemoteDataSourceImpl implements ForecastRemoteDataSource {
  @override
  Future<List<ForecastModel>> getForecast({
    required LocationModel location,
  }) async {
    // TODO(0xfbravo): implement
    return [];
  }
}
