import 'package:testpos/models/debt.dart';
import 'package:testpos/providers/repository/debt_repository.dart';

class DebtController {
  final DebtRepository repository;

  DebtController(this.repository);

  Future<List<Debt>> getAllDebts() async {
    return repository.getAllDebts();
  }

  Future<void> addDebt(Debt debt) async {
    await repository.addDebt(debt);
  }

  Future<void> updateDebt(Debt debt) async {
    await repository.updateDebt(debt);
  }

  Future<void> deleteDebt(Debt debt) async {
    await repository.deleteDebt(debt);
  }
}
