import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/expense.dart';
import '../../providers/expense/expense_provider.dart';

class EditExpenseScreen extends ConsumerStatefulWidget {
  final Expense expense;

  const EditExpenseScreen({required this.expense, super.key});

  @override
  _EditExpenseScreenState createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends ConsumerState<EditExpenseScreen> {
  late TextEditingController _descriptionController;
  late TextEditingController _amountController;
  late String _payer;

  @override
  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: widget.expense.description);
    _amountController =
        TextEditingController(text: widget.expense.amount.toString());
    _payer = widget.expense.payer;
  }

  void _editExpense() {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    if (description.isNotEmpty && amount > 0) {
      widget.expense.description = description;
      widget.expense.amount = amount;
      widget.expense.payer = _payer;
      widget.expense.save();
      ref.read(expenseListProvider.notifier).updateExpense(widget.expense);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Expense'),
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
              onPressed: _editExpense,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
