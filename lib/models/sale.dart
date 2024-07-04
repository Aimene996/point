import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'sale.g.dart';

@HiveType(typeId: 3)
class Sale extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String clientName;

  @HiveField(2)
  double salePrice;

  @HiveField(3)
  String boxKind;

  @HiveField(4)
  int quantity;

  @HiveField(5)
  bool isPaid;

  @HiveField(6)
  DateTime date;

  Sale({
    String? id,
    required this.clientName,
    required this.salePrice,
    required this.boxKind,
    required this.quantity,
    required this.isPaid,
    required this.date,
  }) : id = id ?? Uuid().v4();

  double get totalPrice => salePrice * quantity;
}
