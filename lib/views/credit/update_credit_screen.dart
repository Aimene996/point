// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/credit.dart';
import '../../providers/credit_provider.dart';

class UpdateCreditScreen extends ConsumerStatefulWidget {
  final Credit credit;

  const UpdateCreditScreen({required this.credit, super.key});

  @override
  _UpdateCreditScreenState createState() => _UpdateCreditScreenState();
}

class _UpdateCreditScreenState extends ConsumerState<UpdateCreditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _clientNameController;
  late TextEditingController _amountCreditController;

  @override
  void initState() {
    super.initState();
    _clientNameController =
        TextEditingController(text: widget.credit.clientName);
    _amountCreditController =
        TextEditingController(text: widget.credit.amountCredit.toString());
  }

  void _updateCredit() {
    if (_formKey.currentState!.validate()) {
      final updatedCredit = Credit(
        id: widget.credit.id,
        clientName: _clientNameController.text,
        amountCredit: double.parse(_amountCreditController.text),
        dateTime: widget.credit.dateTime,
      );

      ref.read(creditListProvider.notifier).updateCredit(updatedCredit);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Credit')),
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
                onPressed: _updateCredit,
                child: const Text('Update Credit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
