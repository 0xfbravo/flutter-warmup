// 📦 Package imports:
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:weather_app/core/data/repository.dart';
import 'package:weather_app/core/domain/model/location_model.dart';

abstract class GetLocationsUseCase {
  Future<List<LocationModel>> call({bool forceRefresh = false});
}

class GetLocationsUseCaseImpl implements GetLocationsUseCase {
  final CoreRepository _repository = GetIt.I();

  @override
  Future<List<LocationModel>> call({bool forceRefresh = false}) async {
    return _repository.getLocations();
  }
}
