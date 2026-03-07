import 'package:flutter/material.dart';
import '../../../core/network/cache_helper.dart';
import '../../../core/routes/app_routes.dart';
import '../../../localization_service.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

// ─── Login Mode ───────────────────────────────────────────────
enum _LoginMode { password, otp }

enum _OtpStep { enterNationalId, enterOtp }

// ══════════════════════════════════════════════════════════════
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ── controllers ──────────────────────────────────────────
  final TextEditingController _userController       = TextEditingController();
  final TextEditingController _passwordController   = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _otpController        = TextEditingController();

  // ── state ─────────────────────────────────────────────────
  _LoginMode _mode    = _LoginMode.password;
  _OtpStep   _otpStep = _OtpStep.enterNationalId;
  bool _loading       = false;
  bool _rememberMe    = false;

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    _nationalIdController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  // ── actions ───────────────────────────────────────────────
  void _switchMode(_LoginMode mode) {
    setState(() {
      _mode    = mode;
      _otpStep = _OtpStep.enterNationalId;
    });
  }

  Future<void> _loginWithPassword() async {
    if (_userController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) return;
    setState(() => _loading = true);

    // TODO: استبدل بـ API call حقيقي
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _loading = false);
     Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  Future<void> _sendOtp() async {
    if (_nationalIdController.text.trim().isEmpty) return;
    setState(() => _loading = true);

    // TODO: استبدل بـ API call حقيقي
    // final response = await yourApiService.sendOtp(_nationalIdController.text);
    // if (response.statusCode == 200) {
    //   setState(() => _otpStep = _OtpStep.enterOtp);
    // }
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() {
      _loading = false;
      _otpStep = _OtpStep.enterOtp; // ← يتغير بعد 200 OK
    });
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.trim().isEmpty) return;
    setState(() => _loading = true);

    // TODO: استبدل بـ API call حقيقي
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _loading = false);
    // Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  // ─────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final isArabic = LocalizationService.getLang() == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor:  Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Logo ─────────────────────────────────────
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35,
                color: Colors.white,
                child: Center(
                  child: Image.asset(
                    'assets/images/alhamdsplash.png',
                    width: 150,
                  ),
                ),
              ),

              // ── White Card ────────────────────────────────
              Container(
                width: double.infinity,
                transform: Matrix4.translationValues(0, -30, 0),
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 10),

                    // ── Page Title ──────────────────────────
                    Text(
                      "login".tr(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Mode Toggle ─────────────────────────
                    _ModeToggle(
                      current: _mode,
                      onChanged: _switchMode,
                    ),
                    const SizedBox(height: 24),

                    // ── Form (animated switch) ──────────────
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 260),
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.05),
                            end: Offset.zero,
                          ).animate(anim),
                          child: child,
                        ),
                      ),
                      child: _mode == _LoginMode.password
                          ? _PasswordForm(
                        key: const ValueKey('password'),
                        userController:     _userController,
                        passwordController: _passwordController,
                        isArabic:           isArabic,
                        rememberMe:         _rememberMe,
                        loading:            _loading,
                        onRememberMe: (v) =>
                            setState(() => _rememberMe = v ?? false),
                        onLogin: _loginWithPassword,
                      )
                          : _OtpForm(
                        key: ValueKey(_otpStep),
                        step:                 _otpStep,
                        nationalIdController: _nationalIdController,
                        otpController:        _otpController,
                        isArabic:             isArabic,
                        loading:              _loading,
                        onSendOtp:  _sendOtp,
                        onVerify:   _verifyOtp,
                        onChangeId: () => setState(
                                () => _otpStep = _OtpStep.enterNationalId),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Change Language ─────────────────────
                    // Center(
                    //   child: TextButton(
                    //     onPressed: () async {
                    //       final newLang =
                    //       LocalizationService.getLang() == 'en' ? 'ar' : 'en';
                    //       await LocalizationService.changeLanguage(newLang);
                    //       if (mounted) setState(() {});
                    //     },
                    //     child: Text(
                    //       "change_lang".tr(),
                    //       style: const TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  Mode Toggle
// ══════════════════════════════════════════════════════════════
class _ModeToggle extends StatelessWidget {
  final _LoginMode current;
  final ValueChanged<_LoginMode> onChanged;
  const _ModeToggle({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ToggleBtn(
            label: "login_with_password".tr(),
            active: current == _LoginMode.password,
            onTap: () => onChanged(_LoginMode.password),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _ToggleBtn(
            label: "login_with_otp".tr(),
            active: current == _LoginMode.otp,
            onTap: () => onChanged(_LoginMode.otp),
          ),
        ),
      ],
    );
  }
}

class _ToggleBtn extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _ToggleBtn(
      {required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF86896E) : const Color(0xFFECECE8),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : const Color(0xFF86896E),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  PASSWORD FORM  –  State 1
// ══════════════════════════════════════════════════════════════
class _PasswordForm extends StatelessWidget {
  final TextEditingController userController;
  final TextEditingController passwordController;
  final bool isArabic;
  final bool rememberMe;
  final bool loading;
  final ValueChanged<bool?> onRememberMe;
  final VoidCallback onLogin;

  const _PasswordForm({
    super.key,
    required this.userController,
    required this.passwordController,
    required this.isArabic,
    required this.rememberMe,
    required this.loading,
    required this.onRememberMe,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // اسم المستخدم
        Text("username_label".tr(), style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: "username_hint".tr(),
          controller: userController,
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
        ),
        const SizedBox(height: 20),

        // كلمة المرور
        Text("password_label".tr(), style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: "password_hint".tr(),
          isPassword: true,
          controller: passwordController,
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
        ),
        const SizedBox(height: 10),

        // تذكرني + نسيت كلمة المرور
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: onRememberMe,
                  activeColor: const Color(0xFF86896E),
                ),
                Text("remember_me".tr(),
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "forgot_password?".tr(),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),

        // زر الدخول
        loading
            ? const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF86896E),
          ),
        )
            : CustomButton(
          text: "login".tr(),
          onPressed: onLogin,
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  OTP FORM  –  State 2 & 3
// ══════════════════════════════════════════════════════════════
class _OtpForm extends StatelessWidget {
  final _OtpStep step;
  final TextEditingController nationalIdController;
  final TextEditingController otpController;
  final bool isArabic;
  final bool loading;
  final VoidCallback onSendOtp;
  final VoidCallback onVerify;
  final VoidCallback onChangeId;

  const _OtpForm({
    super.key,
    required this.step,
    required this.nationalIdController,
    required this.otpController,
    required this.isArabic,
    required this.loading,
    required this.onSendOtp,
    required this.onVerify,
    required this.onChangeId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // رقم الهوية
        Text("national_id_label".tr(), style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: "national_id_hint".tr(),
          controller: nationalIdController,
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          keyboardType: TextInputType.number,
          readOnly: step == _OtpStep.enterOtp,
        ),

        // ── State 3: OTP field  (يظهر بعد 200 OK) ────────
        if (step == _OtpStep.enterOtp) ...[
          const SizedBox(height: 20),
          Text("otp_label".tr(), style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          CustomTextField(
            hintText: "otp_hint".tr(),
            controller: otpController,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 8),

          // تغيير رقم الهوية
          Align(
            alignment: isArabic ? Alignment.centerLeft : Alignment.centerRight,
            child: GestureDetector(
              onTap: onChangeId,
              child: Text(
                "change_national_id".tr(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF86896E),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],

        const SizedBox(height: 24),

        // زر الإرسال / التحقق
        loading
            ? const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF86896E),
          ),
        )
            : CustomButton(
          text: step == _OtpStep.enterNationalId
              ? "send_otp".tr()
              : "verify_and_login".tr(),
          onPressed:
          step == _OtpStep.enterNationalId ? onSendOtp : onVerify,
        ),
      ],
    );
  }
}