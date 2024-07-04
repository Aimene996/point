import 'package:flutter/material.dart';
import '../../../models/raw_material.dart';
import '../views/raw/edit_raw_material.dart';

class RawMaterialListTile extends StatelessWidget {
  final RawMaterial rawMaterial;

  const RawMaterialListTile({required this.rawMaterial, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          rawMaterial.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Unit: ${rawMaterial.unit}'),
            Text('Total Quantity: ${rawMaterial.totalQuantity}'),
            Text('Total Price: ${rawMaterial.totalPrice}'),
            Text('Price Per Unit: ${rawMaterial.pricePerUnit}'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            // Implement delete functionality here
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EditRawMaterialScreen(rawMaterial: rawMaterial),
            ),
          );
        },
      ),
    );
  }
}
