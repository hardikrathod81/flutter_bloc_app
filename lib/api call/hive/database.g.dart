// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonDataBaseAdapter extends TypeAdapter<PersonDataBase> {
  @override
  final int typeId = 0;

  @override
  PersonDataBase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonDataBase(
      name: fields[0] as String,
      phoneNumber: fields[1] as String,
      imageUrl: fields[2] as String,
      gender: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PersonDataBase obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonDataBaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
