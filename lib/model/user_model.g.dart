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
      name: fields[2] as String,
      confirmed: fields[3] as bool,
      ecoCoins: fields[4] as int,
      freezeEcoCoins: fields[5] as int,
      token: fields[6] as String,
      inviteCode: fields[7] as String,
      role: fields[8] as String,
      attachedRecPointId: fields[9] as String,
      image: fields[10] as String,
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
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.confirmed)
      ..writeByte(4)
      ..write(obj.ecoCoins)
      ..writeByte(5)
      ..write(obj.freezeEcoCoins)
      ..writeByte(6)
      ..write(obj.token)
      ..writeByte(7)
      ..write(obj.inviteCode)
      ..writeByte(8)
      ..write(obj.role)
      ..writeByte(9)
      ..write(obj.attachedRecPointId)
      ..writeByte(10)
      ..write(obj.image);
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
