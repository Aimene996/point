import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/raw_material.dart';
import '../../../providers/raw_material_provider.dart';

class AddRawMaterialScreen extends ConsumerWidget {
  const AddRawMaterialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rawMaterialForm = ref.watch(rawMaterialFormProvider);
    final rawMaterialFormNotifier = ref.read(rawMaterialFormProvider.notifier);
    final rawMaterialListNotifier = ref.read(rawMaterialListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Raw Material'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => rawMaterialFormNotifier.setName(value),
              decoration: const InputDecoration(labelText: 'Raw Material Name'),
            ),
            const SizedBox(height: 20),
            const Text('Unit'),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('kg'),
                    leading: Radio<String>(
                      value: 'kg',
                      groupValue: rawMaterialForm.unit,
                      onChanged: (String? value) {
                        rawMaterialFormNotifier.setUnit(value!);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('liters'),
                    leading: Radio<String>(
                      value: 'liters',
                      groupValue: rawMaterialForm.unit,
                      onChanged: (String? value) {
                        rawMaterialFormNotifier.setUnit(value!);
                      },
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              onChanged: (value) {
                rawMaterialFormNotifier
                    .setTotalQuantity(double.tryParse(value) ?? 0.0);
              },
              decoration: const InputDecoration(labelText: 'Total Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              onChanged: (value) {
                rawMaterialFormNotifier
                    .setTotalPrice(double.tryParse(value) ?? 0.0);
              },
              decoration: const InputDecoration(labelText: 'Total Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Text(
                'Price Per Unit: ${rawMaterialForm.pricePerUnit.toStringAsFixed(2)}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (rawMaterialForm.name.isEmpty ||
                    rawMaterialForm.totalPrice == 0.0 ||
                    rawMaterialForm.totalQuantity == 0.0 ||
                    rawMaterialForm.pricePerUnit == 0.0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Please fill in all fields with valid data')),
                  );
                  return;
                }

                final rawMaterial = RawMaterial(
                  name: rawMaterialForm.name,
                  unit: rawMaterialForm.unit,
                  pricePerUnit: rawMaterialForm.pricePerUnit,
                  totalPrice: rawMaterialForm.totalPrice,
                  totalQuantity: rawMaterialForm.totalQuantity,
                );

                rawMaterialListNotifier.addRawMaterial(rawMaterial);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: const Text('Add Raw Material'),
            ),
          ],
        ),
      ),
    );
  }
}
