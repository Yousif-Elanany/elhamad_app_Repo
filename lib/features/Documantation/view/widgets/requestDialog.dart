import 'package:alhamd/core/constants/app_colors.dart';
import 'package:flutter/material.dart';



// ─── Show dialog helper ───────────────────────────────────────────────────────

void showDocumentRequestDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.45),
    builder: (_) => const DocumentRequestDialog(),
  );
}

// ─── Dialog widget ────────────────────────────────────────────────────────────

class DocumentRequestDialog extends StatefulWidget {
  const DocumentRequestDialog({super.key});

  @override
  State<DocumentRequestDialog> createState() => _DocumentRequestDialogState();
}

class _DocumentRequestDialogState extends State<DocumentRequestDialog>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _typeCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _titleCtrl.dispose();
    _typeCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            '✓ تم حفظ الطلب بنجاح',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontFamily: 'Cairo'),
          ),
          backgroundColor: AppColors.primaryOlive,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: Dialog(
            backgroundColor:  Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            insetPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Container(
              width: 680,
              padding: const EdgeInsets.fromLTRB(40, 36, 40, 32),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Header ─────────────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'طلب وثيقة',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E1B14),
                          ),
                        ),
                        _CloseButton(onTap: () => Navigator.of(context).pop()),

                      ],
                    ),

                    const SizedBox(height: 32),

                    // ── Two-column row ─────────────────────────────────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _ArabicField(
                            label: 'نوع الطلب',
                            hint: 'ادخل نوع الطلب',
                            controller: _typeCtrl,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _ArabicField(
                            label: 'عنوان الطلب',
                            hint: 'ادخل عنوان الطلب',
                            controller: _titleCtrl,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ── Notes ──────────────────────────────────────────
                    _ArabicField(
                      label: 'ملاحظات',
                      hint: 'ادخل الملاحظات',
                      controller: _notesCtrl,
                      maxLines: 5,
                    ),

                    const SizedBox(height: 28),

                    const Divider(color: Color(0xFFE8E4DC), thickness: 1),

                    const SizedBox(height: 28),

                    // ── Actions ────────────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _ActionButton(
                          label: 'حفظ',
                          isPrimary: true,
                          onPressed: _onSave,
                        ),
                        const SizedBox(width: 14),
                        _ActionButton(
                          label: 'إلغاء',
                          isPrimary: false,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Close button ─────────────────────────────────────────────────────────────

class _CloseButton extends StatefulWidget {
  final VoidCallback onTap;
  const _CloseButton({required this.onTap});

  @override
  State<_CloseButton> createState() => _CloseButtonState();
}

class _CloseButtonState extends State<_CloseButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
            _hovered ? const Color(0xFFE0DDD5) : const Color(0xFFEFEDE8),
          ),
          child: Center(
            child: AnimatedRotation(
              turns: _hovered ? 0.25 : 0,
              duration: const Duration(milliseconds: 180),
              child: const Icon(Icons.close, size: 16, color: Color(0xFF6B6456)),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Arabic text field ────────────────────────────────────────────────────────

class _ArabicField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;

  const _ArabicField({
    required this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF3D3830),
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              '*',
              style: TextStyle(
                color: Color(0xFFC0392B),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
         // textDirection: TextDirection.rtl,
          maxLines: maxLines,
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF1E1B14),
            fontFamily: 'Cairo',
          ),
          validator: (v) =>
          (v == null || v.trim().isEmpty) ? 'هذا الحقل مطلوب' : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFFB5B0A8),
              fontWeight: FontWeight.w300,
              fontFamily: 'Cairo',
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              const BorderSide(color: Color(0xFFDAD6CF), width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              const BorderSide(color: Color(0xFFDAD6CF), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              const BorderSide(color: Color(0xFF7D7258), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              const BorderSide(color: Color(0xFFC0392B), width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              const BorderSide(color: Color(0xFFC0392B), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Action button ────────────────────────────────────────────────────────────

class _ActionButton extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.label,
    required this.isPrimary,
    required this.onPressed,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bg = widget.isPrimary
        ? (_hovered ? const Color(0xFF5A5235) : const Color(0xFF6B6240))
        : (_hovered ? const Color(0xFFF3F0EA) : Colors.white);
    final fg =
    widget.isPrimary ? Colors.white : const Color(0xFF6B6456);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: widget.isPrimary
              ? null
              : Border.all(color: const Color(0xFFDAD6CF), width: 1.5),
          boxShadow: widget.isPrimary && _hovered
              ? [
            BoxShadow(
              color: const Color(0xFF6B6240).withOpacity(0.35),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
              child: Text(
                widget.label,
                style: TextStyle(
                  color: fg,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}