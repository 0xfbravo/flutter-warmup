import 'package:get_it/get_it.dart';
import 'package:weather_app/core/data/repository.dart';
import 'package:weather_app/core/domain/model/saved_location_model.dart';

abstract class SearchLocationUseCase {
  Future<SavedLocationModel> call({
    required String query,
  });
}

class SearchLocationUseCaseImpl implements SearchLocationUseCase {
  final CoreRepository _repository = GetIt.I();

  @override
  Future<SavedLocationModel> call({
    required String query,
  }) async {
    return _repository.searchLocation(query: query);
  }
}
