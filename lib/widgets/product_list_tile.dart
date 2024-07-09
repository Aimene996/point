import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../views/product/edit_product_screen.dart';

class ProductListTile extends ConsumerWidget {
  final Product product;

  const ProductListTile({required this.product, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productListNotifier = ref.read(productListProvider.notifier);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: product.imageUrl != null
            ? Image.network(
                product.imageUrl!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.image_not_supported, size: 50),
        title: Text(
          '${product.name} - ${product.boxSize} pieces',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Production Price: ${product.productionPrice} DZD\n'
          'Box Count: ${product.boxCount}',
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Delete Product'),
                  content: const Text(
                      'Are you sure you want to delete this product?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        productListNotifier.deleteProduct(product);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                );
              },
            );
          },
        ),
        isThreeLine: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProductScreen(product: product),
            ),
          );
        },
      ),
    );
  }
}
