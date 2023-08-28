// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

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
    final dio = GetIt.I<Dio>();
    final path = dotenv.env['OPEN_WEATHER_FORECAST_PATH'] ?? 'unknown';
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

    final forecastList = data['list'] as List<dynamic>?;
    if (forecastList == null || forecastList.isEmpty) {
      throw Exception('No data found for location: $location');
    }

    return forecastList
        .map(
          (dynamic json) => ForecastModel(
            date: json['dt_txt']! as String,
            main: json['weather'][0]['main']! as String,
            description: json['weather'][0]['description']! as String,
            icon: json['weather'][0]['icon']! as String,
            temperature: double.parse(json['main']['temp'].toString()),
            feelsLike: double.parse(json['main']['feels_like'].toString()),
            minTemperature: double.parse(json['main']['temp_min'].toString()),
            maxTemperature: double.parse(json['main']['temp_max'].toString()),
            pressure: json['main']['pressure'] as int?,
            humidity: json['main']['humidity'] as int?,
            seaLevel: json['main']['sea_level'] as int?,
            groundLevel: json['main']['grnd_level'] as int?,
          ),
        )
        .toList();
  }
}
