import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/features/forecast/domain/usecases/get_forecast_usecase.dart';
import 'package:weather_app/features/forecast/presentation/state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  ForecastCubit() : super(ForecastLoading());

  Future<void> getForecast({
    required LocationModel location,
  }) async {
    final getForecaseUseCase = GetIt.I.get<GetForecastUseCase>();
    emit(ForecastLoading());

    try {
      final forecast = await getForecaseUseCase(location: location);
      emit(ForecastLoaded(forecast: forecast));
    } catch (e) {
      GetIt.I<Logger>().e(e.toString(), e);
      emit(ForecastError());
    }
  }
}
