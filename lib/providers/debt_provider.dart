import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/debt.dart';

class DebtListNotifier extends StateNotifier<List<Debt>> {
  DebtListNotifier() : super([]);

  void addDebt(Debt debt) {
    state = [...state, debt];
  }

  void updateDebt(Debt updatedDebt) {
    state = [
      for (final debt in state)
        if (debt.id == updatedDebt.id) updatedDebt else debt,
    ];
  }

  void deleteDebt(Debt debt) {
    state = state.where((d) => d.id != debt.id).toList();
  }
}

final debtListProvider =
    StateNotifierProvider<DebtListNotifier, List<Debt>>((ref) {
  return DebtListNotifier();
});
