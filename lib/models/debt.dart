import 'package:hive/hive.dart';

part 'debt.g.dart';

@HiveType(typeId: 1)
class Debt extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String clientName;

  @HiveField(2)
  double amountDebt;

  @HiveField(3)
  DateTime dateTime;

  Debt({
    required this.id,
    required this.clientName,
    required this.amountDebt,
    required this.dateTime,
  });
}
