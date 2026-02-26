// // --- Step 2: Review ---
// Widget _buildStep2(StateSetter setModalState) {
//   return Column(
//     children: [
//       _buildStepper(2),
//       const SizedBox(height: 20),
//       Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: Column(
//           children: [
//             _buildReviewRow("org_date".tr(), dateController.text),
//             _buildReviewRow("time".tr(), timeController.text),
//             _buildReviewRow("city".tr(), cityController.text),
//             _buildReviewRow("org_location".tr(), locationController.text),
//             _buildReviewRow("email".tr(), emailController.text),
//             _buildReviewRow("regarding".tr(), nameController.text),
//             _buildReviewRow("attachments".tr(), "docs.pdf", isLink: true),
//             const SizedBox(height: 10),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 notesController.text.isEmpty
//                     ? "no_notes".tr()
//                     : notesController.text,
//                 style: const TextStyle(fontSize: 12),
//               ),
//             ),
//           ],
//         ),
//       ),
//       const SizedBox(height: 20),
//       Row(
//         children: [
//           Expanded(
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: primaryOlive,
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//               ),
//               onPressed: () => setModalState(() => currentStep = 3),
//               child: Text(
//                 "confirm_meeting".tr(),
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//               ),
//               onPressed: () => setModalState(() => currentStep = 1),
//               child: Text(
//                 "edit".tr(),
//                 style: const TextStyle(color: Colors.black),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ],
//   );
// }