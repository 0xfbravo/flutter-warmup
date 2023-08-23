import 'package:weather_app/features/current_weather/dependency_injection.dart';
import 'package:weather_app/features/saved_location_forecast/dependency_injection.dart';

void setupDependencyInjection() {
  CurrentWeatherPackage.setup();
  SavedLocationForecastPackage.setup();
}
