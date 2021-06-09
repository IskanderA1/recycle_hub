// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final int typeId = 7;

  @override
  Transaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transaction(
      id: fields[0] as String,
      recPointId: fields[1] as String,
      filterId: fields[2] as String,
      filterName: fields[3] as String,
      amount: fields[4] as double,
      reward: fields[5] as int,
      status: fields[6] as String,
      date: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.recPointId)
      ..writeByte(2)
      ..write(obj.filterId)
      ..writeByte(3)
      ..write(obj.filterName)
      ..writeByte(4)
      ..write(obj.amount)
      ..writeByte(5)
      ..write(obj.reward)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
