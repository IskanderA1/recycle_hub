// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionModelAdapter extends TypeAdapter<TransactionModel> {
  @override
  final int typeId = 7;

  @override
  TransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionModel(
      recUser: fields[0] as UserModel,
      id: fields[1] as String,
      recPoint: fields[2] as CustMarker,
      ammount: fields[3] as int,
      image: fields[4] as String,
      reward: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.recUser)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.recPoint)
      ..writeByte(3)
      ..write(obj.ammount)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.reward);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
