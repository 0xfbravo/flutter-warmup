// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedLocationModel _$SavedLocationModelFromJson(Map<String, dynamic> json) =>
    SavedLocationModel(
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );

Map<String, dynamic> _$SavedLocationModelToJson(SavedLocationModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lat': instance.lat,
      'lon': instance.lon,
    };
