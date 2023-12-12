// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeChangeAdapter extends TypeAdapter<ThemeChange> {
  @override
  final int typeId = 0;

  @override
  ThemeChange read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThemeChange(
      themechange: fields[0] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ThemeChange obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.themechange);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeChangeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
