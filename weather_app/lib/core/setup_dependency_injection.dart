import 'package:weather_app/features/current_location/dependency_injection.dart';
import 'package:weather_app/features/saved_location_forecast/dependency_injection.dart';

void setupDependencyInjection() {
  CurrentLocationWeatherPackage.setup();
  SavedLocationForecastPackage.setup();
}
