// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testpos/models/debt.dart';

import '../../providers/debt_provider.dart';

class AddDebtScreen extends ConsumerStatefulWidget {
  const AddDebtScreen({super.key});

  @override
  _AddDebtScreenState createState() => _AddDebtScreenState();
}

class _AddDebtScreenState extends ConsumerState<AddDebtScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _clientNameController = TextEditingController();
  final _amountDebtController = TextEditingController();

  void _addDebt() {
    if (_formKey.currentState!.validate()) {
      final newDebt = Debt(
        id: _idController.text,
        clientName: _clientNameController.text,
        amountDebt: double.parse(_amountDebtController.text),
        dateTime: DateTime.now(),
      );

      ref.read(debtListProvider.notifier).addDebt(newDebt);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Debt')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an ID';
                  }
                  return null;
                },
              ),
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
                onPressed: _addDebt,
                child: const Text('Add Debt'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
