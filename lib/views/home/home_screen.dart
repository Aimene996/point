import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await FlutterBarcodeScanner.scanBarcode(
              "#ff6666", "Cancel", false, ScanMode.DEFAULT);
        },
        label: const Text('Scan'),
        icon: const Icon(Icons.barcode_reader),
      ),
      appBar: AppBar(
        title: const Text('Inventory Management'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return _buildGridView(context, 4); // 4 columns for web
          } else {
            return _buildGridView(context, 2); // 2 columns for mobile
          }
        },
      ),
    );
  }

  Widget _buildGridView(BuildContext context, int crossAxisCount) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          _buildCard(
            context,
            title: 'Products',
            icon: Icons.shopping_bag,
            color: Colors.blue,
            routeName: '/product_list',
          ),
          // _buildCard(
          //   context,
          //   title: 'Purchases',
          //   icon: Icons.shopping_cart,
          //   color: Colors.green,
          //   routeName: '/purchase_list',
          // ),
          _buildCard(
            context,
            title: 'Raw Materials',
            icon: Icons.inventory,
            color: Colors.orange,
            routeName: '/raw_material_list',
          ),
          _buildCard(
            context,
            title: 'Sales',
            icon: Icons.sell,
            color: Colors.purple,
            routeName: '/sale_list',
          ),
          _buildCard(
            context,
            title: 'Summary',
            icon: Icons.analytics,
            color: Colors.red,
            routeName: '/summary', // Future route
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title,
      required IconData icon,
      required Color color,
      required String routeName}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: color,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
