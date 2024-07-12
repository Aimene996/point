import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/debt.dart';
import '../../providers/debt_provider.dart';

class UpdateDebtScreen extends ConsumerStatefulWidget {
  final Debt debt;

  const UpdateDebtScreen({required this.debt, super.key});

  @override
  _UpdateDebtScreenState createState() => _UpdateDebtScreenState();
}

class _UpdateDebtScreenState extends ConsumerState<UpdateDebtScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _clientNameController;
  late TextEditingController _amountDebtController;

  @override
  void initState() {
    super.initState();
    _clientNameController = TextEditingController(text: widget.debt.clientName);
    _amountDebtController =
        TextEditingController(text: widget.debt.amountDebt.toString());
  }

  void _updateDebt() {
    if (_formKey.currentState!.validate()) {
      final updatedDebt = Debt(
        id: widget.debt.id,
        clientName: _clientNameController.text,
        amountDebt: double.parse(_amountDebtController.text),
        dateTime: widget.debt.dateTime,
      );

      ref.read(debtListProvider.notifier).updateDebt(updatedDebt);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Debt')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _clientNameController,
                decoration: const InputDecoration(labelText: 'Client Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a client name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountDebtController,
                decoration: const InputDecoration(labelText: 'Amount of Debt'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateDebt,
                child: const Text('Update Debt'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
