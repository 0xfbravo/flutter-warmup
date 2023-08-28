// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedLocationModelAdapter extends TypeAdapter<SavedLocationModel> {
  @override
  final int typeId = 1;

  @override
  SavedLocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedLocationModel(
      name: fields[0] as String,
      lat: fields[1] as double,
      lon: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SavedLocationModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.lat)
      ..writeByte(2)
      ..write(obj.lon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedLocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}