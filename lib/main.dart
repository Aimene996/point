import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testpos/views/summary_screen.dart';
import 'models/product.dart';
import 'models/purchase.dart';
import 'models/raw_material.dart';
// Importing the index file
import './views/index.dart';
import 'models/sale.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(PurchaseAdapter());
  Hive.registerAdapter(RawMaterialAdapter());
  Hive.registerAdapter(SaleAdapter());
  await Hive.openBox<Product>('products');
  await Hive.openBox<Purchase>('purchases');
  await Hive.openBox<RawMaterial>('raw_materials');
  await Hive.openBox<Sale>('sales');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventory App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/product_list': (context) => const ProductListScreen(),
        '/add_product': (context) => AddProductScreen(),
        // '/purchase_list': (context) => const PurchaseListScreen(),
        // '/add_purchase': (context) => const AddPurchaseScreen(),
        '/raw_material_list': (context) => const RawMaterialListScreen(),
        '/add_raw_material': (context) => const AddRawMaterialScreen(),
        '/sale_list': (context) => const SaleListScreen(),
        '/add_sale': (context) => const AddSaleScreen(),

        '/summary': (context) => const SummaryScreen(),
      },
    );
  }
}
