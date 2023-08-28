import 'package:weather_app/core/domain/model/location_model.dart';

abstract class ForecastLocalDataSource {
  Future<void> getForecast({
    required LocationModel location,
  });
}

class ForecastLocalDataSourceImpl implements ForecastLocalDataSource {
  @override
  Future<void> getForecast({
    required LocationModel location,
  }) async {
    // TODO(0xfbravo): implement
    return;
  }
}
