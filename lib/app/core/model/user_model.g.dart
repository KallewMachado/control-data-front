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
      name: fields[1] as String,
      email: fields[3] as String,
      dateBirth: fields[4] as DateTime,
      fone: fields[5] as String,
      street: fields[6] as String,
      num: fields[7] as String,
      district: fields[8] as String,
      complement: fields[9] as String?,
      userCreated: fields[10] as String?,
      createdAt: fields[11] as DateTime?,
      demands: (fields[12] as List?)?.cast<dynamic>(),
      cpf: fields[2] as String?,
      adm: fields[13] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.cpf)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.dateBirth)
      ..writeByte(5)
      ..write(obj.fone)
      ..writeByte(6)
      ..write(obj.street)
      ..writeByte(7)
      ..write(obj.num)
      ..writeByte(8)
      ..write(obj.district)
      ..writeByte(9)
      ..write(obj.complement)
      ..writeByte(10)
      ..write(obj.userCreated)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.demands)
      ..writeByte(13)
      ..write(obj.adm);
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
