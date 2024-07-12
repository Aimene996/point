import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/credit.dart';
import 'controllers/credit_controller.dart';

class CreditListNotifier extends StateNotifier<List<Credit>> {
  CreditListNotifier(this.controller) : super([]) {
    _loadCredits();
  }

  final CreditController controller;

  Future<void> _loadCredits() async {
    final credits = await controller.getAllCredits();
    state = credits;
  }

  void addCredit(Credit credit) {
    state = [...state, credit];
    controller.addCredit(credit);
  }

  void updateCredit(Credit updatedCredit) {
    state = [
      for (final credit in state)
        if (credit.id == updatedCredit.id) updatedCredit else credit,
    ];
    controller.updateCredit(updatedCredit);
  }

  void deleteCredit(Credit credit) {
    state = state.where((c) => c.id != credit.id).toList();
    controller.deleteCredit(credit);
  }
}

final creditListProvider =
    StateNotifierProvider<CreditListNotifier, List<Credit>>((ref) {
  final controller = ref.read(creditControllerProvider);
  return CreditListNotifier(controller);
});
