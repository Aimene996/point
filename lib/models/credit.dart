import 'package:hive/hive.dart';

part 'credit.g.dart';

@HiveType(typeId: 2)
class Credit extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String clientName;

  @HiveField(2)
  double amountCredit;

  @HiveField(3)
  DateTime dateTime;

  Credit({
    required this.id,
    required this.clientName,
    required this.amountCredit,
    required this.dateTime,
  });
}
