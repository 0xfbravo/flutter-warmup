import 'package:hive/hive.dart';
import 'package:weather_app/core/domain/model/saved_location_model.dart';
import 'package:weather_app/features/current_weather/domain/model/current_weather_model.dart';

abstract class CurrentWeatherLocalDataSource {
  Future<CurrentWeatherModel?> hasCachedWeather({
    required SavedLocationModel savedLocationModel,
  });
  Future<List<CurrentWeatherModel>> getSavedWeathers();
  Future<bool> saveWeather({
    required SavedLocationModel location,
    required CurrentWeatherModel weather,
  });
}

class CurrentWeatherLocalDataSourceImpl
    implements CurrentWeatherLocalDataSource {
  Future<Box<CurrentWeatherModel>> _getHiveBox() async {
    return Hive.openBox<CurrentWeatherModel>('current_weather');
  }

  @override
  Future<CurrentWeatherModel?> hasCachedWeather({
    required SavedLocationModel savedLocationModel,
  }) async {
    final hiveBox = await _getHiveBox();
    return hiveBox.get(savedLocationModel.name);
  }

  @override
  Future<List<CurrentWeatherModel>> getSavedWeathers() async {
    final hiveBox = await _getHiveBox();
    return hiveBox.values.toList();
  }

  @override
  Future<bool> saveWeather({
    required SavedLocationModel location,
    required CurrentWeatherModel weather,
  }) async {
    final hiveBox = await _getHiveBox();
    await hiveBox.put(location.name, weather);
    return true;
  }
}
