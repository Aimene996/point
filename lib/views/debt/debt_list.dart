import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testpos/views/debt/add_debt_screen.dart';
import '../../models/debt.dart';
import '../../providers/debt_provider.dart';
import 'update_debt_screen.dart'; // Import the update screen

class DebtListScreen extends ConsumerWidget {
  const DebtListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debtList = ref.watch(debtListProvider);

    Debt? highestDebt = debtList.isNotEmpty
        ? debtList.reduce((a, b) => a.amountDebt > b.amountDebt ? a : b)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debt List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddDebtScreen()),
              );
            },
          ),
        ],
      ),
      body: debtList.isEmpty
          ? const Center(child: Text('No debts available'))
          : ListView.builder(
              itemCount: debtList.length,
              itemBuilder: (context, index) {
                final debt = debtList[index];
                return ListTile(
                  title: Text(debt.clientName),
                  subtitle:
                      Text('Amount: ${debt.amountDebt.toStringAsFixed(2)} DZD'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateDebtScreen(debt: debt),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    // Handle debt detail or sold amount
                  },
                );
              },
            ),
      bottomNavigationBar: highestDebt != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Highest Debt: ${highestDebt.clientName} - ${highestDebt.amountDebt.toStringAsFixed(2)} DZD',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
          : null,
    );
  }
}
