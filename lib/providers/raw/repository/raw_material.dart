import 'package:hive/hive.dart';

import '../../../models/raw_material.dart';

class RawMaterialRepository {
  final Box<RawMaterial> _rawMaterialBox =
      Hive.box<RawMaterial>('raw_materials');

  List<RawMaterial> getAllRawMaterials() {
    return _rawMaterialBox.values.toList();
  }

  void addRawMaterial(RawMaterial rawMaterial) {
    _rawMaterialBox.add(rawMaterial);
  }

  void updateRawMaterial(RawMaterial rawMaterial) {
    rawMaterial.save();
  }

  void deleteRawMaterial(RawMaterial rawMaterial) {
    rawMaterial.delete();
  }
}
