import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'raw_material.g.dart';

@HiveType(typeId: 2)
class RawMaterial extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String unit; // e.g., kg, liters

  @HiveField(3)
  double pricePerUnit;

  @HiveField(4)
  double totalPrice;

  @HiveField(5)
  double totalQuantity;

  RawMaterial({
    String? id,
    required this.name,
    required this.unit,
    required this.pricePerUnit,
    required this.totalPrice,
    required this.totalQuantity,
  }) : id = id ?? Uuid().v4();
}
