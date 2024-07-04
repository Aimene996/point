import '../../../models/raw_material.dart';
import '../repository/raw_material.dart';

class RawMaterialController {
  final RawMaterialRepository _rawMaterialRepository;

  RawMaterialController(this._rawMaterialRepository);

  List<RawMaterial> getAllRawMaterials() {
    return _rawMaterialRepository.getAllRawMaterials();
  }

  void addRawMaterial(RawMaterial rawMaterial) {
    _rawMaterialRepository.addRawMaterial(rawMaterial);
  }

  void updateRawMaterial(RawMaterial rawMaterial) {
    _rawMaterialRepository.updateRawMaterial(rawMaterial);
  }

  void deleteRawMaterial(RawMaterial rawMaterial) {
    _rawMaterialRepository.deleteRawMaterial(rawMaterial);
  }
}
