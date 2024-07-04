// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_material.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RawMaterialAdapter extends TypeAdapter<RawMaterial> {
  @override
  final int typeId = 2;

  @override
  RawMaterial read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RawMaterial(
      id: fields[0] as String?,
      name: fields[1] as String,
      unit: fields[2] as String,
      pricePerUnit: fields[3] as double,
      totalPrice: fields[4] as double,
      totalQuantity: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, RawMaterial obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.pricePerUnit)
      ..writeByte(4)
      ..write(obj.totalPrice)
      ..writeByte(5)
      ..write(obj.totalQuantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RawMaterialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
