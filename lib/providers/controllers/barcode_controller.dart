// // lib/controller/barcode_controller.dart

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../repository/barcode_repo.dart';

// final barcodeControllerProvider = Provider((ref) {
//   final barcodeRepository = ref.read(barcodeRepositoryProvider);
//   return BarcodeController(barcodeRepository);
// });

// final barcodeRepositoryProvider = Provider((ref) => BarcodeRepository());

// class BarcodeController {
//   final BarcodeRepository _barcodeRepository;

//   BarcodeController(this._barcodeRepository);

//   Future<String?> scanBarcode() async {
//     return await _barcodeRepository.scanBarcode();
//   }
// }
