import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/core/domain/usecases/get_locations_usecase.dart';
import 'package:weather_app/features/current_weather/presentation/state.dart';

class CurrentWeatherPageCubit extends Cubit<CurrentWeatherPageState> {
  CurrentWeatherPageCubit() : super(CurrentWeatherPageLoading()) {
    getLocations();
  }

  Future<void> getLocations() async {
    final getLocationsUseCase = GetIt.I.get<GetLocationsUseCase>();
    emit(CurrentWeatherPageLoading());
    try {
      final locations = await getLocationsUseCase();
      emit(CurrentWeatherPageLoaded(locations: locations));
    } catch (e) {
      emit(CurrentWeatherPageError());
    }
  }
}
