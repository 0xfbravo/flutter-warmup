import 'package:get_it/get_it.dart';
import 'package:weather_app/core/data/repository.dart';
import 'package:weather_app/core/domain/model/saved_location_model.dart';

abstract class GetSavedLocationsUseCase {
  Future<List<SavedLocationModel>> call();
}

class GetSavedLocationsUseCaseImpl implements GetSavedLocationsUseCase {
  final CoreRepository _repository = GetIt.I();

  @override
  Future<List<SavedLocationModel>> call() async {
    return _repository.getSavedLocations();
  }
}
