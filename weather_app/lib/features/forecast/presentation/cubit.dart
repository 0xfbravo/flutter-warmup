import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/core/domain/usecases/get_locations_usecase.dart';
import 'package:weather_app/features/forecast/presentation/state.dart';

class ForecastPageCubit extends Cubit<ForecastPageState> {
  ForecastPageCubit() : super(ForecastPageLoading()) {
    getLocations();
  }

  Future<void> getLocations() async {
    final getLocationsUseCase = GetIt.I.get<GetLocationsUseCase>();
    emit(ForecastPageLoading());
    try {
      final locations = await getLocationsUseCase();
      emit(ForecastPageLoaded(locations: locations));
    } catch (e) {
      emit(ForecastPageError());
    }
  }
}
