import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testpos/models/product.dart';
import 'package:testpos/models/purchase.dart';
import 'package:testpos/models/raw_material.dart';
import 'package:testpos/models/sale.dart';
import 'package:testpos/views/debt/add_debt_screen.dart';
import 'package:testpos/views/debt/debt_list.dart';
import 'package:testpos/views/expense/add_expenss.dart';
import 'package:testpos/views/expense/edit_expenss.dart';
import 'package:testpos/views/expense/expenss_screen.dart';
import 'package:testpos/views/notifications/notification_screen.dart';
import 'package:testpos/views/summary_screen.dart';
import 'package:testpos/views/index.dart';

import 'models/expense.dart';

void main() async {
  await initializeHive();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> initializeHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(PurchaseAdapter());
  Hive.registerAdapter(RawMaterialAdapter());
  Hive.registerAdapter(SaleAdapter());
  // Hive.registerAdapter(ExpenseAdapter()); // Register the Expense adapter

  await Future.wait([
    Hive.openBox<Product>('products'),
    Hive.openBox<Purchase>('purchases'),
    Hive.openBox<RawMaterial>('raw_materials'),
    Hive.openBox<Sale>('sales'),
    Hive.openBox<Expense>('expenses'), // Open the expenses box
  ]);
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
        '/raw_material_list': (context) => const RawMaterialListScreen(),
        '/add_raw_material': (context) => const AddRawMaterialScreen(),
        '/sale_list': (context) => const SaleListScreen(),
        '/add_sale': (context) => const AddSaleScreen(),
        '/debt': (context) => const DebtListScreen(),
        '/add_debt': (context) => const AddDebtScreen(),
        '/summary': (context) => const SummaryScreen(),
        '/notification': (context) => const Notifications(),
        '/expenses': (context) => const ExpenseScreen(),
        '/add_expense': (context) => const AddExpenseScreen(),
        '/edit_expense': (context) => EditExpenseScreen(
            expense: ModalRoute.of(context)!.settings.arguments
                as Expense), // Edit expense route with arguments
      },
    );
  }
}
