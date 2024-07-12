// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:testpos/views/credit/update_credit_screen.dart';
// import '../../providers/credit_provider.dart';

// import 'add_credit_screen.dart';

// class CreditListScreen extends ConsumerWidget {
//   const CreditListScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final creditList = ref.watch(creditListProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Credit List'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const AddCreditScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: creditList.isEmpty
//           ? const Center(child: Text('No debts available'))
//           : ListView.builder(
//               itemCount: creditList.length,
//               itemBuilder: (context, index) {
//                 final credit = creditList[index];
//                 return ListTile(
//                   title: Text(credit.clientName),
//                   subtitle:
//                       Text('Amount: ${creditList} DZD'),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.edit),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => UpdateCreditScreen(credit: credit),
//                         ),
//                       );
//                     },
//                   ),
//                   onTap: () {
//                     // Handle debt detail or sold amount
//                   },
//                 );
//               },
//             ),
//       bottomNavigationBar:  != null
//           ? Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Highest Debt: ${highestDebt.clientName} - ${highestDebt.amountDebt.toStringAsFixed(2)} DZD',
//                 style:
//                     const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             )
//           : null,
//     );
//   }
// }