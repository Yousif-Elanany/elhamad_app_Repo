import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const ConfirmDeleteDialog({
    super.key,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── زر الإغلاق ──
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: onCancel ?? () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.grey),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),

              const SizedBox(height: 8),

              // ── أيقونة التحذير ──
              Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF8C00),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.white,
                  size: 52,
                ),
              ),

              const SizedBox(height: 20),

              // ── العنوان ──
              const Text(
                'هل أنت متأكد؟',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),

              const SizedBox(height: 12),

              // ── النص ──
              const Text(
                'هل أنت متأكد أنك تريد الحذف؟ إذا واصلت، فسيتم إزالة المهمة نهائيًا من القائمة.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF666666),
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 24),

              // ── الأزرار ──
              Row(
                children: [
                  // إلغاء
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFDDDDDD), width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        foregroundColor: Colors.grey[700],
                      ),
                      onPressed: onCancel ?? () => Navigator.pop(context),
                      child: const Text('إلغاء', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // حفظ / تأكيد
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B7B3A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      onPressed: onConfirm,
                      child: const Text('حفظ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── طريقة الاستخدام ──────────────────────────────
// showDialog(
//   context: context,
//   builder: (_) => ConfirmDeleteDialog(
//     onConfirm: () {
//       Navigator.pop(context);
//       // منطق الحذف هنا
//     },
//   ),
// );