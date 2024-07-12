import 'package:hive/hive.dart';
import '../../../models/product.dart';

class ProductRepository {
  final Box<Product> productBox = Hive.box<Product>('products');

  Future<List<Product>> getAllProducts() async {
    try {
      return productBox.values.toList();
    } catch (e) {
      // Handle error
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      bool productExists = false;
      for (var p in productBox.values) {
        if (p.boxSize == product.boxSize) {
          productExists = true;
          p.boxCount += product.boxCount;
          await p.save();
          break;
        }
      }

      if (!productExists) {
        await productBox.add(product);
      }
    } catch (e) {
      // Handle error
      print('Error adding product: $e');
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await product.save();
    } catch (e) {
      // Handle error
      print('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(Product product) async {
    try {
      await product.delete();
    } catch (e) {
      // Handle error
      print('Error deleting product: $e');
    }
  }

  Future<void> initializeBox() async {
    try {
      if (!Hive.isBoxOpen('products')) {
        await Hive.openBox<Product>('products');
      }
    } catch (e) {
      // Handle error
      print('Error initializing product box: $e');
    }
  }

  Future<void> increaseStock(String productId, int boxSize, int count) async {
    try {
      final product = productBox.get(productId);
      if (product != null) {
        if (boxSize == 6) {
          product.stock6 += count;
        } else if (boxSize == 12) {
          product.stock12 += count;
        } else if (boxSize == 24) {
          product.stock24 += count;
        } else if (boxSize == 36) {
          product.stock36 += count;
        } else {
          throw Exception("Invalid box size");
        }
        await product.save();
      }
    } catch (e) {
      // Handle error
      print('Error increasing stock: $e');
    }
  }

  Future<void> decreaseStock(String productId, int boxSize, int count) async {
    try {
      final product = productBox.get(productId);
      if (product != null) {
        if (boxSize == 6) {
          product.stock6 =
              (product.stock6 - count).clamp(0, double.infinity).toInt();
        } else if (boxSize == 12) {
          product.stock12 =
              (product.stock12 - count).clamp(0, double.infinity).toInt();
        } else if (boxSize == 24) {
          product.stock24 =
              (product.stock24 - count).clamp(0, double.infinity).toInt();
        } else if (boxSize == 36) {
          product.stock36 =
              (product.stock36 - count).clamp(0, double.infinity).toInt();
        } else {
          throw Exception("Invalid box size");
        }
        await product.save();
      }
    } catch (e) {
      // Handle error
      print('Error decreasing stock: $e');
    }
  }
}
