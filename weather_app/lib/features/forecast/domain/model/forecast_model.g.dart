// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForecastModelAdapter extends TypeAdapter<ForecastModel> {
  @override
  final int typeId = 2;

  @override
  ForecastModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForecastModel(
      date: fields[0] as String,
      latitude: fields[1] as double,
      longitude: fields[2] as double,
      main: fields[3] as String,
      description: fields[4] as String,
      icon: fields[5] as String,
      temperature: fields[6] as double,
      feelsLike: fields[7] as double,
      minTemperature: fields[8] as double,
      maxTemperature: fields[9] as double,
      pressure: fields[10] as int?,
      humidity: fields[11] as int?,
      seaLevel: fields[12] as int?,
      groundLevel: fields[13] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ForecastModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude)
      ..writeByte(3)
      ..write(obj.main)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.icon)
      ..writeByte(6)
      ..write(obj.temperature)
      ..writeByte(7)
      ..write(obj.feelsLike)
      ..writeByte(8)
      ..write(obj.minTemperature)
      ..writeByte(9)
      ..write(obj.maxTemperature)
      ..writeByte(10)
      ..write(obj.pressure)
      ..writeByte(11)
      ..write(obj.humidity)
      ..writeByte(12)
      ..write(obj.seaLevel)
      ..writeByte(13)
      ..write(obj.groundLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
