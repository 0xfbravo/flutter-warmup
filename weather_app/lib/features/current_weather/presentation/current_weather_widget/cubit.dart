import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/features/current_weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:weather_app/features/current_weather/presentation/current_weather_widget/state.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  CurrentWeatherCubit() : super(CurrentWeatherLoading());

  Future<void> getCurrentWeather({
    required LocationModel location,
  }) async {
    final getCurrentWeatherUseCase = GetIt.I.get<GetCurrentWeatherUseCase>();
    emit(CurrentWeatherLoading());

    try {
      final weather = await getCurrentWeatherUseCase(location: location);
      emit(CurrentWeatherLoaded(weather: weather));
    } catch (e) {
      GetIt.I<Logger>().e(e.toString(), e);
      emit(CurrentWeatherError());
    }
  }
}
