import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/expense.dart';
import '../repository/expense/expense_repository.dart';

final expenseListProvider =
    StateNotifierProvider<ExpenseListNotifier, List<Expense>>((ref) {
  return ExpenseListNotifier(ref.read(expenseRepositoryProvider));
});

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepository();
});

class ExpenseListNotifier extends StateNotifier<List<Expense>> {
  final ExpenseRepository repository;

  ExpenseListNotifier(this.repository) : super([]) {
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final expenses = await repository.getAllExpenses();
    state = expenses;
  }

  void addExpense(Expense expense) async {
    await repository.addExpense(expense);
    state = [...state, expense];
  }

  void deleteExpense(Expense expense) async {
    await repository.deleteExpense(expense);
    state = state.where((e) => e.id != expense.id).toList();
  }

  void updateExpense(Expense expense) {
    state = [
      for (final e in state)
        if (e.id == expense.id) expense else e,
    ];
  }
}
