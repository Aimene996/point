import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/raw_material.dart';
import '../../../providers/raw_material_provider.dart';

class EditRawMaterialScreen extends ConsumerWidget {
  final RawMaterial rawMaterial;

  const EditRawMaterialScreen({required this.rawMaterial, super.key});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final rawMaterialFormNotifier = watch(rawMaterialFormProvider.notifier);
    final rawMaterialListNotifier = watch(rawMaterialListProvider.notifier);

    // Initialize the form state with the raw material details
    rawMaterialFormNotifier.setName(rawMaterial.name);
    rawMaterialFormNotifier.setUnit(rawMaterial.unit);
    rawMaterialFormNotifier.setTotalPrice(rawMaterial.totalPrice);
    rawMaterialFormNotifier.setTotalQuantity(rawMaterial.totalQuantity);

    final rawMaterialForm = watch(rawMaterialFormProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Raw Material'),
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
              controller: TextEditingController(text: rawMaterial.name),
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
              controller: TextEditingController(
                  text: rawMaterial.totalQuantity.toString()),
            ),
            TextField(
              onChanged: (value) {
                rawMaterialFormNotifier
                    .setTotalPrice(double.tryParse(value) ?? 0.0);
              },
              decoration: const InputDecoration(labelText: 'Total Price'),
              keyboardType: TextInputType.number,
              controller: TextEditingController(
                  text: rawMaterial.totalPrice.toString()),
            ),
            const SizedBox(height: 20),
            Text('Price Per Unit: ${rawMaterialForm.pricePerUnit}'),
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

                final updatedRawMaterial = RawMaterial(
                  id: rawMaterial.id,
                  name: rawMaterialForm.name,
                  unit: rawMaterialForm.unit,
                  pricePerUnit: rawMaterialForm.pricePerUnit,
                  totalPrice: rawMaterialForm.totalPrice,
                  totalQuantity: rawMaterialForm.totalQuantity,
                );

                rawMaterialListNotifier.updateRawMaterial(updatedRawMaterial);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: const Text('Update Raw Material'),
            ),
          ],
        ),
      ),
    );
  }
}
