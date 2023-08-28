// 📦 Package imports:
import 'package:hive/hive.dart';

part 'location_model.g.dart';

@HiveType(typeId: 0)
class LocationModel extends HiveObject {
  LocationModel({
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
