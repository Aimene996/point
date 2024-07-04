import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'purchase.g.dart';

@HiveType(typeId: 1)
class Purchase extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  double price; // Total price for this purchase

  @HiveField(4)
  DateTime date;

  Purchase({
    String? id,
    required this.quantity,
    required this.price,
    required this.date,
  }) : id = id ?? Uuid().v4();
}
