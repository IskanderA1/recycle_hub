// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AcceptTypeAdapter extends TypeAdapter<AcceptType> {
  @override
  final int typeId = 2;

  @override
  AcceptType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AcceptType(
      id: fields[0] as String,
      badWords: (fields[1] as List)?.cast<String>(),
      keyWords: (fields[2] as List)?.cast<String>(),
      name: fields[3] as String,
      varName: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AcceptType obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.badWords)
      ..writeByte(2)
      ..write(obj.keyWords)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.varName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AcceptTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
