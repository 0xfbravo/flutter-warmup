// 📦 Package imports:
import 'package:hive/hive.dart';

// 🌎 Project imports:
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/features/forecast/domain/model/forecast_model.dart';

abstract class ForecastLocalDataSource {
  Future<List<ForecastModel>?> hasCached({
    required LocationModel location,
  });
  Future<List<List<ForecastModel>>> getSavedForecasts();
  Future<bool> saveForecast({
    required LocationModel location,
    required List<ForecastModel> forecast,
  });
}

class ForecastLocalDataSourceImpl implements ForecastLocalDataSource {
  Future<Box<List<dynamic>>> _getHiveBox() async {
    return Hive.openBox<List<dynamic>>('forecast');
  }

  @override
  Future<List<ForecastModel>?> hasCached({
    required LocationModel location,
  }) async {
    final hiveBox = await _getHiveBox();
    return hiveBox
        .get(location.name.trim().toLowerCase().hashCode)
        ?.map((e) => e as ForecastModel)
        .toList();
  }

  @override
  Future<List<List<ForecastModel>>> getSavedForecasts() async {
    final hiveBox = await _getHiveBox();
    return hiveBox.values
        .map((e) => e.map((e) => e as ForecastModel).toList())
        .toList();
  }

  @override
  Future<bool> saveForecast({
    required LocationModel location,
    required List<ForecastModel> forecast,
  }) async {
    final hiveBox = await _getHiveBox();
    await hiveBox.put(location.name.trim().toLowerCase().hashCode, forecast);
    return true;
  }
}
