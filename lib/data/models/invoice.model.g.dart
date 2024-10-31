// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InvoiceAdapter extends TypeAdapter<Invoice> {
  @override
  final int typeId = 1;

  @override
  Invoice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Invoice(
      docId: fields[0] as String?,
      isSynced: fields[1] as bool,
      invoiceNumber: fields[2] as int?,
      invoiceDate: fields[3] as DateTime?,
      paymentMethod: fields[4] as String?,
      clientName: fields[5] as String,
      clientAddress: fields[6] as String?,
      clientEmail: fields[7] as String?,
      clientPhone: fields[8] as String?,
      subtotal: fields[9] as double?,
      extraDiscount: fields[10] as double?,
      totalDiscount: fields[11] as double?,
      totalTaxAmount: fields[12] as double?,
      grandTotal: fields[13] as double?,
      shippingCharges: fields[14] as double?,
      billItems: (fields[15] as List?)?.cast<BillItem>(),
      notes: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Invoice obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.docId)
      ..writeByte(1)
      ..write(obj.isSynced)
      ..writeByte(2)
      ..write(obj.invoiceNumber)
      ..writeByte(3)
      ..write(obj.invoiceDate)
      ..writeByte(4)
      ..write(obj.paymentMethod)
      ..writeByte(5)
      ..write(obj.clientName)
      ..writeByte(6)
      ..write(obj.clientAddress)
      ..writeByte(7)
      ..write(obj.clientEmail)
      ..writeByte(8)
      ..write(obj.clientPhone)
      ..writeByte(9)
      ..write(obj.subtotal)
      ..writeByte(10)
      ..write(obj.extraDiscount)
      ..writeByte(11)
      ..write(obj.totalDiscount)
      ..writeByte(12)
      ..write(obj.totalTaxAmount)
      ..writeByte(13)
      ..write(obj.grandTotal)
      ..writeByte(14)
      ..write(obj.shippingCharges)
      ..writeByte(15)
      ..write(obj.billItems)
      ..writeByte(16)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
