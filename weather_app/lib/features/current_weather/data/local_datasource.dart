// 📦 Package imports:
import 'package:hive/hive.dart';

// 🌎 Project imports:
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/features/current_weather/domain/model/current_weather_model.dart';

abstract class CurrentWeatherLocalDataSource {
  Future<CurrentWeatherModel?> hasCached({
    required LocationModel location,
  });
  Future<List<CurrentWeatherModel>> getSavedWeathers();
  Future<bool> saveWeather({
    required LocationModel location,
    required CurrentWeatherModel weather,
  });
}

class CurrentWeatherLocalDataSourceImpl
    implements CurrentWeatherLocalDataSource {
  Future<Box<CurrentWeatherModel>> _getHiveBox() async {
    return Hive.openBox<CurrentWeatherModel>('current_weather');
  }

  @override
  Future<CurrentWeatherModel?> hasCached({
    required LocationModel location,
  }) async {
    final hiveBox = await _getHiveBox();
    return hiveBox.get(location.name.trim().toLowerCase().hashCode);
  }

  @override
  Future<List<CurrentWeatherModel>> getSavedWeathers() async {
    final hiveBox = await _getHiveBox();
    return hiveBox.values.toList();
  }

  @override
  Future<bool> saveWeather({
    required LocationModel location,
    required CurrentWeatherModel weather,
  }) async {
    final hiveBox = await _getHiveBox();
    await hiveBox.put(location.name.trim().toLowerCase().hashCode, weather);
    return true;
  }
}
