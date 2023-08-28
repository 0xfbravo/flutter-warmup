// 📦 Package imports:
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:weather_app/features/forecast/data/local_datasource.dart';
import 'package:weather_app/features/forecast/data/remote_datasource.dart';
import 'package:weather_app/features/forecast/data/repository.dart';
import 'package:weather_app/features/forecast/domain/usecases/get_forecast_usecase.dart';
import 'package:weather_app/features/forecast/presentation/cubit.dart';
import 'package:weather_app/features/forecast/presentation/forecast_widget/cubit.dart';

class ForecastPackage {
  ForecastPackage._();

  static void setup() {
    _setupData();
    _setupDomain();
    _setupPresentation();
  }

  static void _setupData() {
    GetIt.I
      ..registerFactory<ForecastLocalDataSource>(
        ForecastLocalDataSourceImpl.new,
      )
      ..registerFactory<ForecastRemoteDataSource>(
        ForecastRemoteDataSourceImpl.new,
      )
      ..registerFactory<ForecastRepository>(
        ForecastRepositoryImpl.new,
      );
  }

  static void _setupDomain() {
    GetIt.I.registerFactory<GetForecastUseCase>(
      GetForecastUseCaseImpl.new,
    );
  }

  static void _setupPresentation() {
    GetIt.I
      ..registerFactory<ForecastPageCubit>(
        ForecastPageCubit.new,
      )
      ..registerFactory<ForecastCubit>(
        ForecastCubit.new,
      );
  }
}
