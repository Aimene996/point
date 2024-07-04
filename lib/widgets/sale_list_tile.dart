import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/sale.dart';
import '../providers/sale_provider.dart';

class SaleListTile extends ConsumerWidget {
  final Sale sale;

  const SaleListTile({required this.sale, super.key});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final saleListNotifier = watch(saleListProvider.notifier);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          'Client: ${sale.clientName}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Box Kind: ${sale.boxKind}\nQuantity: ${sale.quantity}\nPrice: \$${sale.salePrice}\nDate: ${sale.date.toLocal()}\nPaid: ${sale.isPaid ? "Yes" : "No"}',
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            saleListNotifier.deleteSale(sale);
          },
        ),
        isThreeLine: true,
      ),
    );
  }
}
