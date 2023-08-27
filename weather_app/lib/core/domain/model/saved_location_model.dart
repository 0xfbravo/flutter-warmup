// 📦 Package imports:
import 'package:hive/hive.dart';
part 'saved_location_model.g.dart';

@HiveType(typeId: 0)
class SavedLocationModel extends HiveObject {
  SavedLocationModel({
    required this.name,
    required this.lat,
    required this.lon,
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final double lat;

  @HiveField(2)
  final double lon;
}
