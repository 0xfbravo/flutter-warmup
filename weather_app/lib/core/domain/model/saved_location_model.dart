// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'saved_location_model.g.dart';

@JsonSerializable()
class SavedLocationModel {
  SavedLocationModel({
    required this.name,
    required this.lat,
    required this.lon,
  });

  factory SavedLocationModel.fromJson(Map<String, dynamic> json) =>
      _$SavedLocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$SavedLocationModelToJson(this);

  final String name;
  final double lat;
  final double lon;
}
