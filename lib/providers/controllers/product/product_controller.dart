import '../../../models/product.dart';
import '../../repository/product/product_repository.dart';

class ProductController {
  final ProductRepository repository;

  ProductController(this.repository);

  Future<List<Product>> getAllProducts() async {
    return repository.getAllProducts();
  }

  Future<void> addProduct(Product product) async {
    await repository.addProduct(product);
  }

  Future<void> updateProduct(Product product) async {
    await repository.updateProduct(product);
  }

  Future<void> deleteProduct(Product product) async {
    await repository.deleteProduct(product);
  }
}
