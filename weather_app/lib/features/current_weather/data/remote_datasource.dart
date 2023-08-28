// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/features/current_weather/domain/model/current_weather_model.dart';

abstract class CurrentWeatherRemoteDataSource {
  Future<CurrentWeatherModel> getCurrentWeather({
    required LocationModel location,
  });
}

class CurrentWeatherRemoteDataSourceImpl
    implements CurrentWeatherRemoteDataSource {
  @override
  Future<CurrentWeatherModel> getCurrentWeather({
    required LocationModel location,
  }) async {
    final dio = GetIt.I<Dio>();
    final path = dotenv.env['OPEN_WEATHER_CURRENT_WEATHER_PATH'] ?? 'unknown';
    final response = await dio.get<dynamic>(
      path,
      queryParameters: {
        'lat': location.lat,
        'lon': location.lon,
        'units': 'metric',
      },
    );

    final data = response.data;
    if (data == null) {
      throw Exception('No data found for location: $location');
    }

    return CurrentWeatherModel(
      latitude: data['coord']['lat']! as double,
      longitude: data['coord']['lon']! as double,
      main: data['weather'][0]['main']! as String,
      description: data['weather'][0]['description']! as String,
      icon: data['weather'][0]['icon']! as String,
      temperature: double.parse(data['main']['temp'].toString()),
      feelsLike: double.parse(data['main']['feels_like'].toString()),
      minTemperature: double.parse(data['main']['temp_min'].toString()),
      maxTemperature: double.parse(data['main']['temp_max'].toString()),
      pressure: data['main']['pressure'] as int?,
      humidity: data['main']['humidity'] as int?,
      seaLevel: data['main']['sea_level'] as int?,
      groundLevel: data['main']['grnd_level'] as int?,
    );
  }
}
