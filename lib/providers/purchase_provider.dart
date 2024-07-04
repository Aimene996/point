import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testpos/providers/repository/purchase/purchase_repository.dart';
import '../models/purchase.dart';
import 'controllers/purchase/purchase_controller.dart';

final purchaseRepositoryProvider = Provider((ref) => PurchaseRepository());

final purchaseControllerProvider = Provider((ref) {
  final repository = ref.watch(purchaseRepositoryProvider);
  return PurchaseController(repository);
});

final purchaseListProvider =
    StateNotifierProvider<PurchaseListNotifier, List<Purchase>>((ref) {
  final controller = ref.watch(purchaseControllerProvider);
  return PurchaseListNotifier(controller);
});

class PurchaseListNotifier extends StateNotifier<List<Purchase>> {
  final PurchaseController _purchaseController;

  PurchaseListNotifier(this._purchaseController) : super([]) {
    _loadPurchases();
  }

  void _loadPurchases() {
    state = _purchaseController.getAllPurchases();
  }

  void addPurchase(Purchase purchase) {
    _purchaseController.addPurchase(purchase);
    state = [...state, purchase];
  }

  void updatePurchase(Purchase purchase) {
    _purchaseController.updatePurchase(purchase);
    state = List.from(state); // to trigger UI update
  }

  void deletePurchase(Purchase purchase) {
    _purchaseController.deletePurchase(purchase);
    state = state.where((p) => p != purchase).toList();
  }

  List<Purchase> filterPurchasesByDate(DateTime startDate, DateTime endDate) {
    return _purchaseController.filterPurchasesByDate(startDate, endDate);
  }

  double calculateTotalCost() {
    return _purchaseController.calculateTotalCost();
  }
}
