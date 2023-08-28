import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/core/domain/model/saved_location_model.dart';
import 'package:weather_app/features/current_weather/domain/model/current_weather_model.dart';

abstract class CurrentWeatherRemoteDataSource {
  Future<CurrentWeatherModel> getCurrentWeather({
    required SavedLocationModel savedLocationModel,
  });
}

class CurrentWeatherRemoteDataSourceImpl
    implements CurrentWeatherRemoteDataSource {
  @override
  Future<CurrentWeatherModel> getCurrentWeather({
    required SavedLocationModel savedLocationModel,
  }) async {
    final dio = GetIt.I<Dio>();
    final path = dotenv.env['OPEN_WEATHER_CURRENT_WEATHER_PATH'] ?? 'unknown';
    final response = await dio.get<dynamic>(
      path,
      queryParameters: {
        'lat': savedLocationModel.lat,
        'lon': savedLocationModel.lon,
        'units': 'metric',
      },
    );

    final data = response.data;
    if (data == null) {
      throw Exception('No data found for location: $savedLocationModel');
    }

    return CurrentWeatherModel(
      latitude: data['coord']['lat']! as double,
      longitude: data['coord']['lon']! as double,
      main: data['weather'][0]['main']! as String,
      description: data['weather'][0]['description']! as String,
      icon: data['weather'][0]['icon']! as String,
      temperature: data['main']['temp']! as double,
      feelsLike: data['main']['feels_like']! as double,
      minTemperature: data['main']['temp_min']! as double,
      maxTemperature: data['main']['temp_max']! as double,
      pressure: data['main']['pressure'] as int?,
      humidity: data['main']['humidity'] as int?,
      seaLevel: data['main']['sea_level'] as int?,
      groundLevel: data['main']['grnd_level'] as int?,
    );
  }
}
