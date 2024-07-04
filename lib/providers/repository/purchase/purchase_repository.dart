import 'package:hive/hive.dart';
import '../../../models/purchase.dart';

class PurchaseRepository {
  final Box<Purchase> _purchaseBox = Hive.box<Purchase>('purchases');

  List<Purchase> getAllPurchases() {
    return _purchaseBox.values.toList();
  }

  void addPurchase(Purchase purchase) {
    _purchaseBox.add(purchase);
  }

  void updatePurchase(Purchase purchase) {
    purchase.save();
  }

  void deletePurchase(Purchase purchase) {
    purchase.delete();
  }

  List<Purchase> filterPurchasesByDate(DateTime startDate, DateTime endDate) {
    return _purchaseBox.values
        .where((purchase) =>
            purchase.date.isAfter(startDate) && purchase.date.isBefore(endDate))
        .toList();
  }
}
