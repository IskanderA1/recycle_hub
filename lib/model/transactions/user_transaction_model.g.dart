// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserTransactionAdapter extends TypeAdapter<UserTransaction> {
  @override
  final int typeId = 17;

  @override
  UserTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserTransaction(
      id: fields[0] as String,
      actionType: fields[1] as String,
      actionId: fields[2] as String,
      ecoCoins: fields[3] as int,
      status: fields[4] as String,
      date: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, UserTransaction obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.actionType)
      ..writeByte(2)
      ..write(obj.actionId)
      ..writeByte(3)
      ..write(obj.ecoCoins)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
