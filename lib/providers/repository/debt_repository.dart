import 'package:hive/hive.dart';
import 'package:testpos/models/debt.dart';

class DebtRepository {
  final Box<Debt> debtBox = Hive.box<Debt>('debts');

  Future<List<Debt>> getAllDebts() async {
    try {
      return debtBox.values.toList();
    } catch (e) {
      // Handle error
      print('Error fetching debts: $e');
      return [];
    }
  }

  Future<void> addDebt(Debt debt) async {
    try {
      await debtBox.add(debt);
    } catch (e) {
      // Handle error
      print('Error adding debt: $e');
    }
  }

  Future<void> updateDebt(Debt debt) async {
    try {
      await debt.save();
    } catch (e) {
      // Handle error
      print('Error updating debt: $e');
    }
  }

  Future<void> deleteDebt(Debt debt) async {
    try {
      await debt.delete();
    } catch (e) {
      // Handle error
      print('Error deleting debt: $e');
    }
  }

  Future<void> initializeBox() async {
    try {
      if (!Hive.isBoxOpen('debts')) {
        await Hive.openBox<Debt>('debts');
      }
    } catch (e) {
      // Handle error
      print('Error initializing debt box: $e');
    }
  }
}
