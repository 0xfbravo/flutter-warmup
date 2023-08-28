// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentWeatherModelAdapter extends TypeAdapter<CurrentWeatherModel> {
  @override
  final int typeId = 1;

  @override
  CurrentWeatherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentWeatherModel(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
      main: fields[2] as String,
      description: fields[3] as String,
      icon: fields[4] as String,
      temperature: fields[5] as double,
      feelsLike: fields[6] as double,
      minTemperature: fields[7] as double,
      maxTemperature: fields[8] as double,
      pressure: fields[9] as double,
      humidity: fields[10] as double,
      seaLevel: fields[11] as double?,
      groundLevel: fields[12] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentWeatherModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.main)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.icon)
      ..writeByte(5)
      ..write(obj.temperature)
      ..writeByte(6)
      ..write(obj.feelsLike)
      ..writeByte(7)
      ..write(obj.minTemperature)
      ..writeByte(8)
      ..write(obj.maxTemperature)
      ..writeByte(9)
      ..write(obj.pressure)
      ..writeByte(10)
      ..write(obj.humidity)
      ..writeByte(11)
      ..write(obj.seaLevel)
      ..writeByte(12)
      ..write(obj.groundLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentWeatherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
