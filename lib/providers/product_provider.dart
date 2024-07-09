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

  void increaseStock(String productId, int boxSize, int count) {
    state = [
      for (final product in state)
        if (product.id == productId)
          _increaseStock(product, boxSize, count)
        else
          product,
    ];
  }

  void decreaseStock(String productId, int boxSize, int count) {
    state = [
      for (final product in state)
        if (product.id == productId)
          _decreaseStock(product, boxSize, count)
        else
          product,
    ];
  }

  Product _increaseStock(Product product, int boxSize, int count) {
    switch (boxSize) {
      case 6:
        return Product(
          id: product.id,
          name: product.name,
          productionPrice: product.productionPrice,
          boxSize: product.boxSize,
          boxCount: product.boxCount,
          barcode6: product.barcode6,
          barcode12: product.barcode12,
          barcode24: product.barcode24,
          barcode36: product.barcode36,
          imageUrl: product.imageUrl,
          stock6: product.stock6 + count,
          stock12: product.stock12,
          stock24: product.stock24,
          stock36: product.stock36,
        );
      case 12:
        return Product(
          id: product.id,
          name: product.name,
          productionPrice: product.productionPrice,
          boxSize: product.boxSize,
          boxCount: product.boxCount,
          barcode6: product.barcode6,
          barcode12: product.barcode12,
          barcode24: product.barcode24,
          barcode36: product.barcode36,
          imageUrl: product.imageUrl,
          stock6: product.stock6,
          stock12: product.stock12 + count,
          stock24: product.stock24,
          stock36: product.stock36,
        );
      case 24:
        return Product(
          id: product.id,
          name: product.name,
          productionPrice: product.productionPrice,
          boxSize: product.boxSize,
          boxCount: product.boxCount,
          barcode6: product.barcode6,
          barcode12: product.barcode12,
          barcode24: product.barcode24,
          barcode36: product.barcode36,
          imageUrl: product.imageUrl,
          stock6: product.stock6,
          stock12: product.stock12,
          stock24: product.stock24 + count,
          stock36: product.stock36,
        );
      case 36:
        return Product(
          id: product.id,
          name: product.name,
          productionPrice: product.productionPrice,
          boxSize: product.boxSize,
          boxCount: product.boxCount,
          barcode6: product.barcode6,
          barcode12: product.barcode12,
          barcode24: product.barcode24,
          barcode36: product.barcode36,
          imageUrl: product.imageUrl,
          stock6: product.stock6,
          stock12: product.stock12,
          stock24: product.stock24,
          stock36: product.stock36 + count,
        );
      default:
        throw Exception("Invalid box size");
    }
  }

  Product _decreaseStock(Product product, int boxSize, int count) {
    switch (boxSize) {
      case 6:
        return Product(
          id: product.id,
          name: product.name,
          productionPrice: product.productionPrice,
          boxSize: product.boxSize,
          boxCount: product.boxCount,
          barcode6: product.barcode6,
          barcode12: product.barcode12,
          barcode24: product.barcode24,
          barcode36: product.barcode36,
          imageUrl: product.imageUrl,
          stock6: (product.stock6 - count).clamp(0, double.infinity).toInt(),
          stock12: product.stock12,
          stock24: product.stock24,
          stock36: product.stock36,
        );
      case 12:
        return Product(
          id: product.id,
          name: product.name,
          productionPrice: product.productionPrice,
          boxSize: product.boxSize,
          boxCount: product.boxCount,
          barcode6: product.barcode6,
          barcode12: product.barcode12,
          barcode24: product.barcode24,
          barcode36: product.barcode36,
          imageUrl: product.imageUrl,
          stock6: product.stock6,
          stock12: (product.stock12 - count).clamp(0, double.infinity).toInt(),
          stock24: product.stock24,
          stock36: product.stock36,
        );
      case 24:
        return Product(
          id: product.id,
          name: product.name,
          productionPrice: product.productionPrice,
          boxSize: product.boxSize,
          boxCount: product.boxCount,
          barcode6: product.barcode6,
          barcode12: product.barcode12,
          barcode24: product.barcode24,
          barcode36: product.barcode36,
          imageUrl: product.imageUrl,
          stock6: product.stock6,
          stock12: product.stock12,
          stock24: (product.stock24 - count).clamp(0, double.infinity).toInt(),
          stock36: product.stock36,
        );
      case 36:
        return Product(
          id: product.id,
          name: product.name,
          productionPrice: product.productionPrice,
          boxSize: product.boxSize,
          boxCount: product.boxCount,
          barcode6: product.barcode6,
          barcode12: product.barcode12,
          barcode24: product.barcode24,
          barcode36: product.barcode36,
          imageUrl: product.imageUrl,
          stock6: product.stock6,
          stock12: product.stock12,
          stock24: product.stock24,
          stock36: (product.stock36 - count).clamp(0, double.infinity).toInt(),
        );
      default:
        throw Exception("Invalid box size");
    }
  }
}

final productListProvider =
    StateNotifierProvider<ProductListNotifier, List<Product>>((ref) {
  return ProductListNotifier();
});
