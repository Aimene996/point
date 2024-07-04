import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testpos/providers/raw/controller/raw_material_controller.dart';
import 'package:testpos/providers/raw/repository/raw_material.dart';
import '../../../models/raw_material.dart';

final rawMaterialRepositoryProvider = Provider<RawMaterialRepository>((ref) {
  return RawMaterialRepository();
});

final rawMaterialControllerProvider = Provider<RawMaterialController>((ref) {
  final repository = ref.watch(rawMaterialRepositoryProvider);
  return RawMaterialController(repository);
});

final rawMaterialFormProvider =
    StateNotifierProvider<RawMaterialFormNotifier, RawMaterialFormState>((ref) {
  return RawMaterialFormNotifier();
});

class RawMaterialFormState {
  final String name;
  final String unit;
  final double totalPrice;
  final double totalQuantity;
  final double pricePerUnit;

  RawMaterialFormState({
    this.name = '',
    this.unit = 'kg',
    this.totalPrice = 0.0,
    this.totalQuantity = 0.0,
    this.pricePerUnit = 0.0,
  });

  RawMaterialFormState copyWith({
    String? name,
    String? unit,
    double? totalPrice,
    double? totalQuantity,
    double? pricePerUnit,
  }) {
    return RawMaterialFormState(
      name: name ?? this.name,
      unit: unit ?? this.unit,
      totalPrice: totalPrice ?? this.totalPrice,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      pricePerUnit: pricePerUnit ?? this.pricePerUnit,
    );
  }
}

class RawMaterialFormNotifier extends StateNotifier<RawMaterialFormState> {
  RawMaterialFormNotifier() : super(RawMaterialFormState());

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setUnit(String unit) {
    state = state.copyWith(unit: unit);
  }

  void setTotalPrice(double totalPrice) {
    state = state.copyWith(totalPrice: totalPrice);
    _calculatePricePerUnit();
  }

  void setTotalQuantity(double totalQuantity) {
    state = state.copyWith(totalQuantity: totalQuantity);
    _calculatePricePerUnit();
  }

  void _calculatePricePerUnit() {
    if (state.totalPrice != 0.0 && state.totalQuantity != 0.0) {
      state =
          state.copyWith(pricePerUnit: state.totalPrice / state.totalQuantity);
    } else {
      state = state.copyWith(pricePerUnit: 0.0);
    }
  }
}

final rawMaterialListProvider =
    StateNotifierProvider<RawMaterialListNotifier, List<RawMaterial>>((ref) {
  final controller = ref.watch(rawMaterialControllerProvider);
  return RawMaterialListNotifier(controller);
});

class RawMaterialListNotifier extends StateNotifier<List<RawMaterial>> {
  final RawMaterialController _controller;

  RawMaterialListNotifier(this._controller)
      : super(_controller.getAllRawMaterials());

  void addRawMaterial(RawMaterial rawMaterial) {
    _controller.addRawMaterial(rawMaterial);
    state = _controller.getAllRawMaterials();
  }

  void updateRawMaterial(RawMaterial rawMaterial) {
    _controller.updateRawMaterial(rawMaterial);
    state = _controller.getAllRawMaterials();
  }

  void deleteRawMaterial(RawMaterial rawMaterial) {
    _controller.deleteRawMaterial(rawMaterial);
    state = _controller.getAllRawMaterials();
  }
}
