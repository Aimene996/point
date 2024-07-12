import 'package:hive/hive.dart';

import '../../../models/credit.dart';

class CreditRepository {
  final Box<Credit> creditBox = Hive.box<Credit>('credits');

  Future<List<Credit>> getAllCredits() async {
    try {
      return creditBox.values.toList();
    } catch (e) {
      // Handle error
      print('Error fetching credits: $e');
      return [];
    }
  }

  Future<void> addCredit(Credit credit) async {
    try {
      await creditBox.add(credit);
    } catch (e) {
      // Handle error
      print('Error adding credit: $e');
    }
  }

  Future<void> updateCredit(Credit credit) async {
    try {
      await credit.save();
    } catch (e) {
      // Handle error
      print('Error updating credit: $e');
    }
  }

  Future<void> deleteCredit(Credit credit) async {
    try {
      await credit.delete();
    } catch (e) {
      // Handle error
      print('Error deleting credit: $e');
    }
  }

  Future<void> initializeBox() async {
    try {
      if (!Hive.isBoxOpen('credits')) {
        await Hive.openBox<Credit>('credits');
      }
    } catch (e) {
      // Handle error
      print('Error initializing credit box: $e');
    }
  }
}
