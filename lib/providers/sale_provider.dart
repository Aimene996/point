import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testpos/providers/repository/sale/sale_repository.dart';

import '../models/sale.dart';
import 'controllers/sale/sale_controller.dart';

final saleRepositoryProvider = Provider((ref) => SaleRepository());

final saleControllerProvider = Provider((ref) {
  final repository = ref.watch(saleRepositoryProvider);
  return SaleController(repository);
});

final saleListProvider =
    StateNotifierProvider<SaleListNotifier, List<Sale>>((ref) {
  final controller = ref.watch(saleControllerProvider);
  return SaleListNotifier(controller);
});

class SaleListNotifier extends StateNotifier<List<Sale>> {
  final SaleController _saleController;

  SaleListNotifier(this._saleController) : super([]) {
    _loadSales();
  }

  void _loadSales() {
    state = _saleController.getAllSales();
  }

  void addSale(Sale sale) {
    _saleController.addSale(sale);
    state = [...state, sale];
  }

  void updateSale(Sale sale) {
    _saleController.updateSale(sale);
    state = List.from(state); // to trigger UI update
  }

  void deleteSale(Sale sale) {
    _saleController.deleteSale(sale);
    state = state.where((p) => p.id != sale.id).toList();
  }

  List<Sale> filterSalesByDate(DateTime startDate, DateTime endDate) {
    return _saleController.filterSalesByDate(startDate, endDate);
  }

  double calculateTotalRevenue() {
    return _saleController.calculateTotalRevenue();
  }

  double calculateProfit() {
    return _saleController.calculateProfit();
  }
}
