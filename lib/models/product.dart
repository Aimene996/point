import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double productionPrice;

  @HiveField(3)
  int boxSize;

  @HiveField(4)
  int boxCount;

  @HiveField(5)
  String barcode6;

  @HiveField(6)
  String barcode12;

  @HiveField(7)
  String barcode24;

  @HiveField(8)
  String barcode36;

  @HiveField(9) // New field index
  String? imageUrl; // Optional field

  @HiveField(10)
  int stock6;

  @HiveField(11)
  int stock12;

  @HiveField(12)
  int stock24;

  @HiveField(13)
  int stock36;

  Product({
    String? id,
    required this.name,
    required this.productionPrice,
    required this.boxSize,
    required this.boxCount,
    required this.barcode6,
    required this.barcode12,
    required this.barcode24,
    required this.barcode36,
    this.imageUrl,
    this.stock6 = 0,
    this.stock12 = 0,
    this.stock24 = 0,
    this.stock36 = 0,
  }) : id = id ?? Uuid().v4();
}
