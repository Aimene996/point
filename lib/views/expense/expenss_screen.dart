import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../models/expense.dart';
import '../../providers/expense/expense_provider.dart';

class ExpenseScreen extends ConsumerStatefulWidget {
  const ExpenseScreen({super.key});

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends ConsumerState<ExpenseScreen> {
  String _filter = 'All';
  String _userFilter = 'All';
  late List<Expense> filteredExpenses;

  void _navigateToAddExpense(BuildContext context) {
    Navigator.pushNamed(context, '/add_expense');
  }

  void _navigateToEditExpense(BuildContext context, Expense expense) {
    Navigator.pushNamed(context, '/edit_expense', arguments: expense);
  }

  void _filterExpenses() {
    final allExpenses = ref.read(expenseListProvider);
    DateTime now = DateTime.now();

    filteredExpenses = allExpenses.where((expense) {
      if (_filter == 'Week') {
        DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        if (!(expense.date.isAfter(startOfWeek) &&
            expense.date.isBefore(now))) {
          return false;
        }
      } else if (_filter == 'Month') {
        DateTime startOfMonth = DateTime(now.year, now.month, 1);
        if (!(expense.date.isAfter(startOfMonth) &&
            expense.date.isBefore(now))) {
          return false;
        }
      }

      if (_userFilter != 'All' && expense.payer != _userFilter) {
        return false;
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final expenses = ref.watch(expenseListProvider);
    _filterExpenses();

    double totalExpenses = filteredExpenses.fold(
      0,
      (sum, item) => sum + item.amount,
    );

    double aimeneExpenses = filteredExpenses
        .where((expense) => expense.payer == 'Aimene')
        .fold(0, (sum, item) => sum + item.amount);

    double faresExpenses = filteredExpenses
        .where((expense) => expense.payer == 'Fares')
        .fold(0, (sum, item) => sum + item.amount);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: 'Add Expense',
          onPressed: () {
            _navigateToAddExpense(context);
          }),
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.add),
          //   onPressed: () => _navigateToAddExpense(context),
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _filter,
                  items: <String>['All', 'Week', 'Month'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _filter = newValue!;
                    });
                    _filterExpenses();
                  },
                ),
                DropdownButton<String>(
                  value: _userFilter,
                  items: <String>['All', 'Aimene', 'Fares'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _userFilter = newValue!;
                    });
                    _filterExpenses();
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredExpenses.length,
                itemBuilder: (context, index) {
                  final expense = filteredExpenses[index];
                  bool isNewDay = index == 0 ||
                      filteredExpenses[index - 1].date.day != expense.date.day;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isNewDay)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            DateFormat.yMMMd().format(expense.date),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8.0),
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal,
                            child: Text(
                              expense.payer[0],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            expense.description,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${expense.amount.toStringAsFixed(2)} DZD\n${expense.payer}\n${DateFormat.yMMMd().format(expense.date)}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              ref
                                  .read(expenseListProvider.notifier)
                                  .deleteExpense(expense);
                            },
                          ),
                          onTap: () => _navigateToEditExpense(context, expense),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Text(
                  'Total: ${totalExpenses.toStringAsFixed(2)} DZD',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Aimene: ${aimeneExpenses.toStringAsFixed(2)} DZD',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Fares: ${faresExpenses.toStringAsFixed(2)} DZD',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
