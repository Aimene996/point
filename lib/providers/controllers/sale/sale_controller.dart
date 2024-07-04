import '../../../models/sale.dart';
import '../../repository/sale/sale_repository.dart';

class SaleController {
  final SaleRepository _saleRepository;

  SaleController(this._saleRepository);

  List<Sale> getAllSales() {
    return _saleRepository.getAllSales();
  }

  void addSale(Sale sale) {
    _saleRepository.addSale(sale);
  }

  void updateSale(Sale sale) {
    _saleRepository.updateSale(sale);
  }

  void deleteSale(Sale sale) {
    _saleRepository.deleteSale(sale);
  }

  List<Sale> filterSalesByDate(DateTime startDate, DateTime endDate) {
    return _saleRepository.filterSalesByDate(startDate, endDate);
  }

  double calculateTotalRevenue() {
    return _saleRepository
        .getAllSales()
        .fold(0.0, (sum, sale) => sum + sale.totalPrice);
  }

  double calculateProfit() {
    return _saleRepository.getAllSales().fold(
        0.0,
        (sum, sale) =>
            sum + sale.totalPrice); // Add logic for profit calculation
  }
}
