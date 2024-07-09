import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/product.dart';
import '../../providers/product_provider.dart';

// ignore: must_be_immutable
class AddProductScreen extends ConsumerWidget {
  AddProductScreen({super.key});

  final TextEditingController productionPriceController =
      TextEditingController();
  final TextEditingController boxCountController = TextEditingController();
  final TextEditingController barcodeController =
      TextEditingController(); // Single controller for barcode

  final List<int> boxSizes = [6, 12, 24, 36];
  int selectedBoxSize = 6;
  DateTime selectedDate = DateTime.now();
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    _image = await _picker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productListNotifier = ref.read(productListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField<int>(
                value: selectedBoxSize,
                onChanged: (int? newValue) {
                  selectedBoxSize = newValue!;
                },
                items: boxSizes.map((int size) {
                  return DropdownMenuItem<int>(
                    value: size,
                    child: Text('$size pieces'),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Box Size'),
              ),
              TextField(
                controller: productionPriceController,
                decoration:
                    const InputDecoration(labelText: 'Production Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: boxCountController,
                decoration: const InputDecoration(labelText: 'Number of Boxes'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: barcodeController, // Single text field for barcode
                decoration: const InputDecoration(labelText: 'Barcode'),
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
              if (_image != null)
                Image.file(File(_image!.path), height: 150)
              else
                TextButton(
                  onPressed: _pickImage,
                  child: const Text('Pick Image'),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final productionPrice =
                      double.tryParse(productionPriceController.text);
                  final boxCount = int.tryParse(boxCountController.text);
                  final barcode = barcodeController.text;

                  if (productionPrice == null ||
                      boxCount == null ||
                      barcode.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Please fill in all fields with valid data')),
                    );
                    return;
                  }

                  String barcode6 = '';
                  String barcode12 = '';
                  String barcode24 = '';
                  String barcode36 = '';

                  // Assign barcode based on selected box size
                  switch (selectedBoxSize) {
                    case 6:
                      barcode6 = barcode;
                      break;
                    case 12:
                      barcode12 = barcode;
                      break;
                    case 24:
                      barcode24 = barcode;
                      break;
                    case 36:
                      barcode36 = barcode;
                      break;
                  }

                  final product = Product(
                    name: 'جوزية',
                    boxSize: selectedBoxSize,
                    productionPrice: productionPrice,
                    boxCount: boxCount,
                    barcode6: barcode6,
                    barcode12: barcode12,
                    barcode24: barcode24,
                    barcode36: barcode36,
                    imageUrl: _image != null ? _image!.path : null,
                  );
                  print(product);

                  productListNotifier.addProduct(product);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
