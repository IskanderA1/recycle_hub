// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_day.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkDayAdapter extends TypeAdapter<WorkDay> {
  @override
  final int typeId = 5;

  @override
  WorkDay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkDay(
      first: fields[0] as String,
      second: fields[1] as String,
      third: fields[2] as String,
      fourth: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WorkDay obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.first)
      ..writeByte(1)
      ..write(obj.second)
      ..writeByte(2)
      ..write(obj.third)
      ..writeByte(3)
      ..write(obj.fourth);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
