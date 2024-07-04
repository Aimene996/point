import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

class ProductListNotifier extends StateNotifier<List<Product>> {
  ProductListNotifier() : super([]);

  void addProduct(Product product) {
    state = [...state, product];
  }

  void updateProduct(Product updatedProduct) {
    state = [
      for (final product in state)
        if (product.id == updatedProduct.id) updatedProduct else product,
    ];
  }

  void deleteProduct(Product product) {
    state = state.where((p) => p.id != product.id).toList();
  }
}

final productListProvider =
    StateNotifierProvider<ProductListNotifier, List<Product>>((ref) {
  return ProductListNotifier();
});
