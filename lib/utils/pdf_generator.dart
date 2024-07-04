// ignore_for_file: deprecated_member_use

import 'package:path_provider/path_provider.dart'; // Import this package
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../models/sale.dart';

import 'dart:io';

Future<void> generatePdf(List<Sale> sales) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Text('Sales Report',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
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
                  sale.id.substring(0, 2),
                  sale.clientName,
                  sale.boxKind,
                  sale.quantity.toString(),
                  '${sale.salePrice.toStringAsFixed(2)} DZD',
                  sale.date.toLocal().toString(),
                  sale.isPaid ? 'Yes' : 'No',
                ];
              }).toList(),
            ),
          ],
        );
      },
    ),
  );

  final output = await getTemporaryDirectory();
  final file = File('${output.path}/sales_report.pdf');
  await file.writeAsBytes(await pdf.save());

  await Printing.sharePdf(
      bytes: await pdf.save(), filename: 'sales_report.pdf');
}
