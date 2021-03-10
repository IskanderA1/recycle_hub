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
      acceptTypes: (fields[1] as List)?.cast<AcceptType>(),
      address: fields[2] as String,
      contacts: (fields[3] as List)?.cast<Contact>(),
      coords: fields[4] as Coords,
      description: fields[5] as String,
      images: (fields[6] as List)?.cast<String>(),
      name: fields[7] as String,
      paybackType: fields[8] as String,
      receptionType: fields[9] as String,
      workTime: fields[10] as WorkingTime,
    );
  }

  @override
  void write(BinaryWriter writer, CustMarker obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.acceptTypes)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.contacts)
      ..writeByte(4)
      ..write(obj.coords)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.images)
      ..writeByte(7)
      ..write(obj.name)
      ..writeByte(8)
      ..write(obj.paybackType)
      ..writeByte(9)
      ..write(obj.receptionType)
      ..writeByte(10)
      ..write(obj.workTime);
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
