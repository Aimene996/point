import 'package:hive/hive.dart';

import '../../../models/sale.dart';

class SaleRepository {
  final Box<Sale> _saleBox = Hive.box<Sale>('sales');

  List<Sale> getAllSales() {
    return _saleBox.values.toList();
  }

  void addSale(Sale sale) {
    _saleBox.add(sale);
  }

  void updateSale(Sale sale) {
    sale.save();
  }

  void deleteSale(Sale sale) {
    sale.delete();
  }

  List<Sale> filterSalesByDate(DateTime startDate, DateTime endDate) {
    return _saleBox.values
        .where((sale) =>
            sale.date.isAfter(startDate) && sale.date.isBefore(endDate))
        .toList();
  }
}
