import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testpos/views/raw/raw_material_screen.dart';
import '../../../providers/raw_material_provider.dart';
import '../../../widgets/raw_material_list_tile.dart';

class RawMaterialListScreen extends ConsumerWidget {
  const RawMaterialListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rawMaterials = ref.read(rawMaterialListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Raw Materials'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: rawMaterials.length,
          itemBuilder: (context, index) {
            final rawMaterial = rawMaterials[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: RawMaterialListTile(rawMaterial: rawMaterial),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddRawMaterialScreen()),
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
