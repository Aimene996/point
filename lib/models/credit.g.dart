// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreditAdapter extends TypeAdapter<Credit> {
  @override
  final int typeId = 2;

  @override
  Credit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Credit(
      id: fields[0] as String,
      clientName: fields[1] as String,
      amountCredit: fields[2] as double,
      dateTime: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Credit obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.clientName)
      ..writeByte(2)
      ..write(obj.amountCredit)
      ..writeByte(3)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreditAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
