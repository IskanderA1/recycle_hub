// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_time.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkingTimeAdapter extends TypeAdapter<WorkingTime> {
  @override
  final int typeId = 4;

  @override
  WorkingTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkingTime(
      mon: fields[0] as WorkDay,
      thu: fields[1] as WorkDay,
      wed: fields[2] as WorkDay,
      thr: fields[3] as WorkDay,
      fri: fields[4] as WorkDay,
      sat: fields[5] as WorkDay,
      sun: fields[6] as WorkDay,
    );
  }

  @override
  void write(BinaryWriter writer, WorkingTime obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.mon)
      ..writeByte(1)
      ..write(obj.thu)
      ..writeByte(2)
      ..write(obj.wed)
      ..writeByte(3)
      ..write(obj.thr)
      ..writeByte(4)
      ..write(obj.fri)
      ..writeByte(5)
      ..write(obj.sat)
      ..writeByte(6)
      ..write(obj.sun);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkingTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
