import 'package:weather_app/core/domain/model/location_model.dart';

abstract class ForecastRemoteDataSource {
  Future<void> getForecast({
    required LocationModel location,
  });
}

class ForecastRemoteDataSourceImpl implements ForecastRemoteDataSource {
  @override
  Future<void> getForecast({
    required LocationModel location,
  }) async {
    // TODO(0xfbravo): implement
    return;
  }
}
