// 🌎 Project imports:
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/features/forecast/domain/model/forecast_model.dart';

abstract class ForecastLocalDataSource {
  Future<List<ForecastModel>> getForecast({
    required LocationModel location,
  });
}

class ForecastLocalDataSourceImpl implements ForecastLocalDataSource {
  @override
  Future<List<ForecastModel>> getForecast({
    required LocationModel location,
  }) async {
    // TODO(0xfbravo): implement
    return [];
  }
}
