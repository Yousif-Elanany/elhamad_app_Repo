// Widget _buildStep3() {
//   return Column(
//     children: [
//       const SizedBox(height: 30),
//       const Icon(Icons.check_circle, color: Color(0xFF27AE60), size: 100),
//       const SizedBox(height: 20),
//       Text(
//         "success_msg".tr(),
//         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       ),
//       const SizedBox(height: 10),
//       Text(
//         "success_submsg".tr(),
//         textAlign: TextAlign.center,
//         style: const TextStyle(fontSize: 14, color: Colors.grey),
//       ),
//       const SizedBox(height: 35),
//       SizedBox(
//         width: double.infinity,
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: primaryOlive,
//             padding: const EdgeInsets.symmetric(vertical: 14),
//           ),
//           onPressed: () {
//             organizationsBox.add(
//               Organization(
//                 name: nameController.text,
//                 description: locationController.text,
//               ),
//             );
//             Navigator.pop(context);
//             _clearControllers();
//           },
//           child: Text(
//             "ok".tr(),
//             style: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }
