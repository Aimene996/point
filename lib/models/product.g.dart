// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      id: fields[0] as String?,
      name: fields[1] as String,
      productionPrice: fields[2] as double,
      boxSize: fields[3] as int,
      boxCount: fields[4] as int,
      barcode6: fields[5] as String,
      barcode12: fields[6] as String,
      barcode24: fields[7] as String,
      barcode36: fields[8] as String,
      imageUrl: fields[9] as String?,
      stock6: fields[10] as int,
      stock12: fields[11] as int,
      stock24: fields[12] as int,
      stock36: fields[13] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.productionPrice)
      ..writeByte(3)
      ..write(obj.boxSize)
      ..writeByte(4)
      ..write(obj.boxCount)
      ..writeByte(5)
      ..write(obj.barcode6)
      ..writeByte(6)
      ..write(obj.barcode12)
      ..writeByte(7)
      ..write(obj.barcode24)
      ..writeByte(8)
      ..write(obj.barcode36)
      ..writeByte(9)
      ..write(obj.imageUrl)
      ..writeByte(10)
      ..write(obj.stock6)
      ..writeByte(11)
      ..write(obj.stock12)
      ..writeByte(12)
      ..write(obj.stock24)
      ..writeByte(13)
      ..write(obj.stock36);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
