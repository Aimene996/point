import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testpos/models/credit.dart';

import '../../providers/credit_provider.dart';

class AddCreditScreen extends ConsumerStatefulWidget {
  const AddCreditScreen({super.key});

  @override
  _AddCreditScreenState createState() => _AddCreditScreenState();
}

class _AddCreditScreenState extends ConsumerState<AddCreditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _clientNameController = TextEditingController();
  final _amountCreditController = TextEditingController();

  void _addCredit() {
    if (_formKey.currentState!.validate()) {
      final newCredit = Credit(
        id: _idController.text,
        clientName: _clientNameController.text,
        amountCredit: double.parse(_amountCreditController.text),
        dateTime: DateTime.now(),
      );

      ref.read(creditListProvider.notifier).addCredit(newCredit);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Credit')),
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
                controller: _amountCreditController,
                decoration:
                    const InputDecoration(labelText: 'Amount of Credit'),
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
                onPressed: _addCredit,
                child: const Text('Add Credit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
