import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/credit.dart';

import '../repository/credit/credit_repository.dart';

class CreditController {
  final CreditRepository repository;

  CreditController(this.repository);

  Future<List<Credit>> getAllCredits() async {
    return repository.getAllCredits();
  }

  Future<void> addCredit(Credit credit) async {
    await repository.addCredit(credit);
  }

  Future<void> updateCredit(Credit credit) async {
    await repository.updateCredit(credit);
  }

  Future<void> deleteCredit(Credit credit) async {
    await repository.deleteCredit(credit);
  }
}

final creditRepositoryProvider = Provider<CreditRepository>((ref) {
  return CreditRepository();
});

final creditControllerProvider = Provider<CreditController>((ref) {
  final repository = ref.read(creditRepositoryProvider);
  return CreditController(repository);
});
