abstract class CurrentWeatherState {}

class CurrentWeatherInitial extends CurrentWeatherState {}

class CurrentWeatherLoading extends CurrentWeatherState {}

class CurrentWeatherError extends CurrentWeatherState {}

class CurrentWeatherLoaded extends CurrentWeatherState {}
