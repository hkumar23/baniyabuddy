// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<TransactionDetails> {
  @override
  final int typeId = 5;

  @override
  TransactionDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionDetails(
      docId: fields[0] as String?,
      customerName: fields[1] as String,
      mobNumber: fields[2] as String,
      notes: fields[3] as String,
      paymentMethod: fields[4] as String,
      timeStamp: fields[5] as DateTime,
      totalAmount: fields[6] as String?,
      inputExpression: fields[7] as String?,
      isSynced: fields[8] as bool,
      syncStatus: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionDetails obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.docId)
      ..writeByte(1)
      ..write(obj.customerName)
      ..writeByte(2)
      ..write(obj.mobNumber)
      ..writeByte(3)
      ..write(obj.notes)
      ..writeByte(4)
      ..write(obj.paymentMethod)
      ..writeByte(5)
      ..write(obj.timeStamp)
      ..writeByte(6)
      ..write(obj.totalAmount)
      ..writeByte(7)
      ..write(obj.inputExpression)
      ..writeByte(8)
      ..write(obj.isSynced)
      ..writeByte(9)
      ..write(obj.syncStatus);
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
