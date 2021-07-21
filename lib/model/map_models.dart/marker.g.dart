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
      address: fields[7] as String,
      contacts: (fields[8] as List)?.cast<String>(),
      acceptTypesNames: (fields[9] as List)?.cast<String>(),
      acceptTypes: (fields[10] as List)?.cast<String>(),
      coords: (fields[11] as List)?.cast<double>(),
      description: fields[12] as String,
      getBonus: fields[13] as bool,
      images: (fields[14] as List)?.cast<String>(),
      externalImages: (fields[15] as List)?.cast<String>(),
      approveStatus: fields[16] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CustMarker obj) {
    writer
      ..writeByte(17)
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
      ..write(obj.address)
      ..writeByte(8)
      ..write(obj.contacts)
      ..writeByte(9)
      ..write(obj.acceptTypesNames)
      ..writeByte(10)
      ..write(obj.acceptTypes)
      ..writeByte(11)
      ..write(obj.coords)
      ..writeByte(12)
      ..write(obj.description)
      ..writeByte(13)
      ..write(obj.getBonus)
      ..writeByte(14)
      ..write(obj.images)
      ..writeByte(15)
      ..write(obj.externalImages)
      ..writeByte(16)
      ..write(obj.approveStatus);
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
