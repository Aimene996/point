import 'package:hive/hive.dart';
import '../../../models/expense.dart';

class ExpenseRepository {
  final Box<Expense> expenseBox = Hive.box<Expense>('expenses');

  Future<List<Expense>> getAllExpenses() async {
    try {
      return expenseBox.values.toList();
    } catch (e) {
      // Handle error
      print('Error fetching expenses: $e');
      return [];
    }
  }

  Future<void> addExpense(Expense expense) async {
    try {
      await expenseBox.add(expense);
    } catch (e) {
      // Handle error
      print('Error adding expense: $e');
    }
  }

  Future<void> deleteExpense(Expense expense) async {
    try {
      await expense.delete();
    } catch (e) {
      // Handle error
      print('Error deleting expense: $e');
    }
  }

  Future<void> initializeBox() async {
    try {
      if (!Hive.isBoxOpen('expenses')) {
        await Hive.openBox<Expense>('expenses');
      }
    } catch (e) {
      // Handle error
      print('Error initializing expense box: $e');
    }
  }
}
