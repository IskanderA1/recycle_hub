// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilterTypeAdapter extends TypeAdapter<FilterType> {
  @override
  final int typeId = 2;

  @override
  FilterType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilterType(
      id: fields[0] as String,
      name: fields[1] as String,
      varName: fields[2] as String,
      keyWords: (fields[3] as List)?.cast<String>(),
      badWords: (fields[4] as List)?.cast<String>(),
      coinsPerUnit: fields[5] as double,
      image: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FilterType obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.varName)
      ..writeByte(3)
      ..write(obj.keyWords)
      ..writeByte(4)
      ..write(obj.badWords)
      ..writeByte(5)
      ..write(obj.coinsPerUnit)
      ..writeByte(6)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
