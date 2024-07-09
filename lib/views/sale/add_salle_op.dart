import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/product.dart';
import '../../models/sale.dart';
import '../../providers/product_provider.dart';
import '../../providers/sale_provider.dart';

class AddSaleScreen extends ConsumerWidget {
  const AddSaleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.read(productListProvider);
    final saleListNotifier = ref.read(saleListProvider.notifier);
    final TextEditingController clientNameController = TextEditingController();
    final TextEditingController salePriceController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    bool isPaid = false;
    String selectedBoxKind = productList.isNotEmpty ? productList[0].name : '';
    DateTime selectedDate = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Sale'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: clientNameController,
              decoration: const InputDecoration(labelText: 'Client Name'),
            ),
            TextField(
              controller: salePriceController,
              decoration: const InputDecoration(labelText: 'Sale Price'),
              keyboardType: TextInputType.number,
            ),
            DropdownButtonFormField<String>(
              value: selectedBoxKind,
              onChanged: (String? newValue) {
                selectedBoxKind = newValue!;
              },
              items: productList.map((Product product) {
                return DropdownMenuItem<String>(
                  value: product.name,
                  child: Text('${product.name} (${product.boxSize} pieces)'),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Box Kind'),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            SwitchListTile(
              title: const Text('Paid'),
              value: isPaid,
              onChanged: (bool value) {
                isPaid = value;
              },
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
                final sale = Sale(
                  clientName: clientNameController.text,
                  salePrice: double.parse(salePriceController.text),
                  boxKind: selectedBoxKind,
                  quantity: int.parse(quantityController.text),
                  isPaid: isPaid,
                  date: selectedDate,
                );
                saleListNotifier.addSale(sale);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: const Text('Add Sale'),
            ),
          ],
        ),
      ),
    );
  }
}
