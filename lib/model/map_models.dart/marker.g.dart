// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marker.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustMarkerAdapter extends TypeAdapter<CustMarker> {
  @override
  final int typeId = 1;

  @override
  CustMarker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustMarker(
      id: fields[0] as String,
      name: fields[1] as String,
      partner: fields[2] as String,
      partnerName: fields[3] as String,
      paybackType: fields[4] as String,
      receptionType: fields[5] as String,
      workTime: fields[6] as WorkingTime,
      contacts: (fields[7] as List)?.cast<String>(),
      acceptTypes: (fields[8] as List)?.cast<String>(),
      coords: (fields[9] as List)?.cast<double>(),
      description: fields[10] as String,
      getBonus: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CustMarker obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.partner)
      ..writeByte(3)
      ..write(obj.partnerName)
      ..writeByte(4)
      ..write(obj.paybackType)
      ..writeByte(5)
      ..write(obj.receptionType)
      ..writeByte(6)
      ..write(obj.workTime)
      ..writeByte(7)
      ..write(obj.contacts)
      ..writeByte(8)
      ..write(obj.acceptTypes)
      ..writeByte(9)
      ..write(obj.coords)
      ..writeByte(10)
      ..write(obj.description)
      ..writeByte(11)
      ..write(obj.getBonus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustMarkerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
