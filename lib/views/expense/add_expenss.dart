import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/expense.dart';
import '../../providers/expense/expense_provider.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  String _payer = 'Aimene';

  void _addExpense() {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    if (description.isNotEmpty && amount > 0) {
      final expense = Expense(
        id: DateTime.now().toString(),
        description: description,
        amount: amount,
        payer: _payer,
        date: DateTime.now(),
      );
      ref.read(expenseListProvider.notifier).addExpense(expense);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: _payer,
              items: ['Aimene', 'Fares'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _payer = newValue!;
                });
              },
            ),
            ElevatedButton(
              onPressed: _addExpense,
              child: const Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
