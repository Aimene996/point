// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../models/product.dart';
import '../../providers/product_provider.dart';

class EditProductScreen extends ConsumerWidget {
  final Product product;

  EditProductScreen({required this.product, super.key});

  final TextEditingController productionPriceController =
      TextEditingController();
  final TextEditingController boxCountController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    _image = await _picker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      imageUrlController.text = _image!.path;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productListNotifier = ref.read(productListProvider.notifier);

    // Pre-fill controllers with product data
    productionPriceController.text = product.productionPrice.toString();
    boxCountController.text = product.boxCount.toString();
    barcodeController.text = product.boxSize == 6
        ? product.barcode6
        : product.boxSize == 12
            ? product.barcode12
            : product.boxSize == 24
                ? product.barcode24
                : product.barcode36;
    imageUrlController.text = product.imageUrl ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: productionPriceController,
                decoration:
                    const InputDecoration(labelText: 'Production Price (DZD)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: boxCountController,
                decoration: const InputDecoration(labelText: 'Number of Boxes'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: barcodeController,
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
              if (imageUrlController.text.isNotEmpty)
                Image.file(File(imageUrlController.text), height: 150)
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

                  // Update product fields
                  product.productionPrice = productionPrice;
                  product.boxCount = boxCount;

                  if (product.boxSize == 6) {
                    product.barcode6 = barcode;
                  } else if (product.boxSize == 12) {
                    product.barcode12 = barcode;
                  } else if (product.boxSize == 24) {
                    product.barcode24 = barcode;
                  } else if (product.boxSize == 36) {
                    product.barcode36 = barcode;
                  }

                  product.imageUrl = imageUrlController.text.isNotEmpty
                      ? imageUrlController.text
                      : null;

                  productListNotifier.updateProduct(product);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                child: const Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
