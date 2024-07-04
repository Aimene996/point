import '../../../models/purchase.dart';
import '../../repository/purchase/purchase_repository.dart';

class PurchaseController {
  final PurchaseRepository _purchaseRepository;

  PurchaseController(this._purchaseRepository);

  List<Purchase> getAllPurchases() {
    return _purchaseRepository.getAllPurchases();
  }

  void addPurchase(Purchase purchase) {
    _purchaseRepository.addPurchase(purchase);
  }

  void updatePurchase(Purchase purchase) {
    _purchaseRepository.updatePurchase(purchase);
  }

  void deletePurchase(Purchase purchase) {
    _purchaseRepository.deletePurchase(purchase);
  }

  List<Purchase> filterPurchasesByDate(DateTime startDate, DateTime endDate) {
    return _purchaseRepository.filterPurchasesByDate(startDate, endDate);
  }

  double calculateTotalCost() {
    return _purchaseRepository.getAllPurchases().fold(
        0.0, (sum, purchase) => sum + (purchase.price * purchase.quantity));
  }
}
