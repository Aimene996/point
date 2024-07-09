// // lib/repository/barcode_repository.dart

// class BarcodeRepository {
//   final BarcodeScanner _barcodeScanner = BarcodeScanner();

//   Future<String?> scanBarcode() async {
//     try {
//       final barcode = await _barcodeScanner.scan();
//       return barcode;
//     } catch (e) {
//       // Handle error appropriately
//       print("Error scanning barcode: $e");
//       return null;
//     }
//   }
// }
