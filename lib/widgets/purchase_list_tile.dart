import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/purchase.dart';
import '../providers/purchase_provider.dart';

class PurchaseListTile extends ConsumerWidget {
  final Purchase purchase;

  const PurchaseListTile({required this.purchase, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchaseListNotifier = ref.read(purchaseListProvider.notifier);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          'Product ID: ${purchase.id}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Quantity: ${purchase.quantity}\nPrice: \$${purchase.price}\nDate: ${purchase.date.toLocal()}',
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            purchaseListNotifier.deletePurchase(purchase);
          },
        ),
        isThreeLine: true,
      ),
    );
  }
}
