// import 'package:flutter/material.dart';
//
// import '../../../../localization_service.dart';
//
// void showAddTaskSheet() {
//   currentStep = 1;
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//
//
//     backgroundColor: Colors.white,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (context) => StatefulBuilder(
//       builder: (context, setModalState) => SizedBox(
//         height: MediaQuery.of(context).size.height * 0.8, // 👈 80%
//         child: Padding(
//           padding: EdgeInsets.only(
//             left: 20,
//             right: 20,
//             top: 15,
//             bottom: MediaQuery.of(context).viewInsets.bottom + 20,
//           ),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "add_Task".tr(),
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.close),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 10),
//
//               Expanded( // 👈 مهم عشان المحتوى يتمدد جوه الـ 80%
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       if (currentStep == 1)
//                         buildStep1(setModalState)
//                       else if (currentStep == 2)
//                         buildStep2(setModalState)
//                       else
//                         buildStep3(),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   ).then((_) => setState(() {}));
// }