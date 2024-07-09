import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../providers/raw_material_provider.dart';
import '../providers/sale_provider.dart';
import '../models/product.dart';
import '../models/raw_material.dart';
import '../models/sale.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.read(productListProvider);
    final rawMaterials = ref.read(rawMaterialListProvider);
    final sales = ref.read(saleListProvider);
    final totalProfit = ref.read(saleListProvider.notifier).calculateProfit();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Summary'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Products'),
              _buildProductSummary(products),
              const SizedBox(height: 20),
              _buildSectionTitle('Raw Materials'),
              _buildRawMaterialSummary(rawMaterials),
              const SizedBox(height: 20),
              _buildSectionTitle('Sales'),
              _buildSaleSummary(sales),
              const SizedBox(height: 20),
              _buildSectionTitle('Total Profit'),
              Text(
                '${totalProfit.toStringAsFixed(2)} DZD',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildProductSummary(List<Product> products) {
    const int lowStockThreshold = 10;

    return DataTable(
      columns: const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Box Size')),
        DataColumn(label: Text('Production Price')),
        DataColumn(label: Text('Box Count')),
      ],
      rows: products
          .map(
            (product) => DataRow(
              color: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (product.boxCount < lowStockThreshold) {
                    return Colors.red
                        .withOpacity(0.3); // Highlight row if stock is low
                  }
                  return null; // Use default color otherwise
                },
              ),
              cells: [
                DataCell(Text(product.id)), // Display first 2 characters of ID
                DataCell(Text(product.name)),
                DataCell(Text(product.boxSize.toString())),
                DataCell(
                    Text('${product.productionPrice.toStringAsFixed(2)} DZD')),
                DataCell(Text(product.boxCount.toString())),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _buildRawMaterialSummary(List<RawMaterial> rawMaterials) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Unit')),
        DataColumn(label: Text('Price per Unit')),
        DataColumn(label: Text('Total Price')),
      ],
      rows: rawMaterials
          .map(
            (rawMaterial) => DataRow(
              cells: [
                DataCell(
                    Text(rawMaterial.id)), // Display first 2 characters of ID
                DataCell(Text(rawMaterial.name)),
                DataCell(Text(rawMaterial.unit)),
                DataCell(
                    Text('${rawMaterial.pricePerUnit.toStringAsFixed(2)} DZD')),
                DataCell(
                    Text('${rawMaterial.totalPrice.toStringAsFixed(2)} DZD')),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _buildSaleSummary(List<Sale> sales) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Client Name')),
        DataColumn(label: Text('Box Kind')),
        DataColumn(label: Text('Quantity')),
        DataColumn(label: Text('Sale Price')),
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Paid')),
      ],
      rows: sales
          .map(
            (sale) => DataRow(
              cells: [
                DataCell(Text(sale.id)), // Display first 2 characters of ID
                DataCell(Text(sale.clientName)),
                DataCell(Text(sale.boxKind)),
                DataCell(Text(sale.quantity.toString())),
                DataCell(Text('${sale.salePrice.toStringAsFixed(2)} DZD')),
                DataCell(Text(sale.date.toLocal().toString())),
                DataCell(Text(sale.isPaid ? 'Yes' : 'No')),
              ],
            ),
          )
          .toList(),
    );
  }
}
