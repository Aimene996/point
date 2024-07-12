// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../providers/product_provider.dart';
import '../providers/raw_material_provider.dart';
import '../providers/sale_provider.dart';
import '../providers/debt_provider.dart';
import '../models/product.dart';
import '../models/raw_material.dart';
import '../models/sale.dart';
import '../models/debt.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider);
    final rawMaterials = ref.watch(rawMaterialListProvider);
    final sales = ref.watch(saleListProvider);
    final debts = ref.watch(debtListProvider);
    final totalProfit = ref.read(saleListProvider.notifier).calculateProfit();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Summary'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () async {
              await generatePdf(
                context,
                products,
                rawMaterials,
                sales,
                debts,
                totalProfit,
              );
            },
          ),
        ],
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
              _buildSectionTitle('Debts'),
              _buildDebtSummary(debts),
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

  Widget _buildDebtSummary(List<Debt> debts) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Client Name')),
        DataColumn(label: Text('Amount')),
        DataColumn(label: Text('Date')),
      ],
      rows: debts
          .map(
            (debt) => DataRow(
              cells: [
                DataCell(Text(debt.id)), // Display first 2 characters of ID
                DataCell(Text(debt.clientName)),
                DataCell(Text('${debt.amountDebt.toStringAsFixed(2)} DZD')),
                DataCell(Text(debt.dateTime.toLocal().toString())),
              ],
            ),
          )
          .toList(),
    );
  }

  Future<void> generatePdf(
    BuildContext context,
    List<Product> products,
    List<RawMaterial> rawMaterials,
    List<Sale> sales,
    List<Debt> debts,
    double totalProfit,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          _buildPdfSectionTitle('Products'),
          _buildPdfProductSummary(products),
          pw.SizedBox(height: 20),
          _buildPdfSectionTitle('Raw Materials'),
          _buildPdfRawMaterialSummary(rawMaterials),
          pw.SizedBox(height: 20),
          _buildPdfSectionTitle('Sales'),
          _buildPdfSaleSummary(sales),
          pw.SizedBox(height: 20),
          _buildPdfSectionTitle('Debts'),
          _buildPdfDebtSummary(debts),
          pw.SizedBox(height: 20),
          _buildPdfSectionTitle('Total Profit'),
          pw.Text(
            '${totalProfit.toStringAsFixed(2)} DZD',
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  pw.Widget _buildPdfSectionTitle(String title) {
    return pw.Text(
      title,
      style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
    );
  }

  pw.Widget _buildPdfProductSummary(List<Product> products) {
    const int lowStockThreshold = 10;

    return pw.Table.fromTextArray(
      headers: ['ID', 'Name', 'Box Size', 'Production Price', 'Box Count'],
      data: products.map((product) {
        return [
          product.id,
          product.name,
          product.boxSize.toString(),
          '${product.productionPrice.toStringAsFixed(2)} DZD',
          product.boxCount.toString(),
        ];
      }).toList(),
    );
  }

  pw.Widget _buildPdfRawMaterialSummary(List<RawMaterial> rawMaterials) {
    return pw.Table.fromTextArray(
      headers: ['ID', 'Name', 'Unit', 'Price per Unit', 'Total Price'],
      data: rawMaterials.map((rawMaterial) {
        return [
          rawMaterial.id,
          rawMaterial.name,
          rawMaterial.unit,
          '${rawMaterial.pricePerUnit.toStringAsFixed(2)} DZD',
          '${rawMaterial.totalPrice.toStringAsFixed(2)} DZD',
        ];
      }).toList(),
    );
  }

  pw.Widget _buildPdfSaleSummary(List<Sale> sales) {
    return pw.Table.fromTextArray(
      headers: [
        'ID',
        'Client Name',
        'Box Kind',
        'Quantity',
        'Sale Price',
        'Date',
        'Paid'
      ],
      data: sales.map((sale) {
        return [
          sale.id,
          sale.clientName,
          sale.boxKind,
          sale.quantity.toString(),
          '${sale.salePrice.toStringAsFixed(2)} DZD',
          sale.date.toLocal().toString(),
          sale.isPaid ? 'Yes' : 'No',
        ];
      }).toList(),
    );
  }

  pw.Widget _buildPdfDebtSummary(List<Debt> debts) {
    return pw.Table.fromTextArray(
      headers: ['ID', 'Client Name', 'Amount', 'Date'],
      data: debts.map((debt) {
        return [
          debt.id,
          debt.clientName,
          '${debt.amountDebt.toStringAsFixed(2)} DZD',
          debt.dateTime.toLocal().toString(),
        ];
      }).toList(),
    );
  }
}
