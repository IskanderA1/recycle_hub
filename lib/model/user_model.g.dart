// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String,
      username: fields[1] as String,
      surname: fields[2] as String,
      name: fields[3] as String,
      password: fields[4] as String,
      image: fields[5] as String,
      confirmed: fields[6] as bool,
      ecoCoins: fields[7] as int,
      refCode: fields[8] as int,
      qrCode: fields[9] as String,
      token: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.surname)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.confirmed)
      ..writeByte(7)
      ..write(obj.ecoCoins)
      ..writeByte(8)
      ..write(obj.refCode)
      ..writeByte(9)
      ..write(obj.qrCode)
      ..writeByte(10)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
