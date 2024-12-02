// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusinessAdapter extends TypeAdapter<Business> {
  @override
  final int typeId = 3;

  @override
  Business read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Business(
      name: fields[0] as String?,
      address: fields[1] as String?,
      email: fields[2] as String?,
      phone: fields[3] as String?,
      gstin: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Business obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.gstin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
