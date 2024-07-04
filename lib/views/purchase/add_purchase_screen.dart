import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/product.dart';
import '../../models/purchase.dart';
import '../../providers/product_provider.dart';
import '../../providers/purchase_provider.dart';

class AddPurchaseScreen extends ConsumerWidget {
  const AddPurchaseScreen({super.key});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final productList = watch(productListProvider);
    final purchaseListNotifier = watch(purchaseListProvider.notifier);
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    String selectedProductId = productList.isNotEmpty ? productList[0].id : '';
    DateTime selectedDate = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Purchase'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedProductId,
              onChanged: (String? newValue) {
                selectedProductId = newValue!;
              },
              items: productList.map((Product product) {
                return DropdownMenuItem<String>(
                  value: product.id,
                  child: Text('${product.name} - ${product.boxSize} pieces'),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Product'),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            ListTile(
              title: Text("Date: ${selectedDate.toLocal()}"),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null && pickedDate != selectedDate) {
                  selectedDate = pickedDate;
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final purchase = Purchase(
                  quantity: int.parse(quantityController.text),
                  price: double.parse(priceController.text),
                  date: selectedDate,
                );
                purchaseListNotifier.addPurchase(purchase);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: const Text('Add Purchase'),
            ),
          ],
        ),
      ),
    );
  }
}
