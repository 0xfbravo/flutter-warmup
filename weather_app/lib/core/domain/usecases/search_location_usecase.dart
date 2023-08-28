// 📦 Package imports:
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:weather_app/core/data/repository.dart';
import 'package:weather_app/core/domain/model/location_model.dart';

abstract class SearchLocationUseCase {
  Future<LocationModel> call({
    required String query,
  });
}

class SearchLocationUseCaseImpl implements SearchLocationUseCase {
  final CoreRepository _repository = GetIt.I();

  @override
  Future<LocationModel> call({
    required String query,
  }) async {
    return _repository.searchLocation(query: query);
  }
}
