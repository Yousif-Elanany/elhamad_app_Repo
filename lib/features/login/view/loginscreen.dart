import 'package:alhamd/features/login/services/auth_remote_data_source.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routes/app_routes.dart';
import '../../../localization_service.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../repo/auth_Repo.dart';
import '../viewModel/login_cubit.dart';
import '../model/LoginRequestModel.dart';

// ─── Login Mode ───────────────────────────────────────────────
enum _LoginMode { password, otp }

enum _OtpStep { enterNationalId, enterOtp }

// ══════════════════════════════════════════════════════════════

class LoginPageWrapper extends StatelessWidget {
  const LoginPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(AuthRepository(AuthRemoteDataSource())),
      child: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ── controllers ──────────────────────────────────────────
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  // ── form keys ─────────────────────────────────────────────
  final _passwordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();

  // ── state ─────────────────────────────────────────────────
  _LoginMode _mode = _LoginMode.password;
  _OtpStep _otpStep = _OtpStep.enterNationalId;
  bool _rememberMe = false;

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    _nationalIdController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  // ── network check ─────────────────────────────────────────
  Future<bool> _hasNetwork() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  void _showNoNetworkSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("no_internet".tr()),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  void _onChangeId() {
    setState(() {
      _otpStep = _OtpStep.enterNationalId;
      _otpFormKey = GlobalKey<FormState>(); // key جديد
    });
  }
  // ── actions ───────────────────────────────────────────────
  void _switchMode(_LoginMode mode) {
    setState(() {
      _mode = mode;
      _otpStep = _OtpStep.enterNationalId;
      _otpFormKey = GlobalKey<FormState>(); // key جديد
    });
  }
  Future<void> _loginWithPassword() async {
    if (!(_passwordFormKey.currentState?.validate() ?? false)) return;

    // ── network check ──────────────────────────────────────
    if (!await _hasNetwork()) {
      _showNoNetworkSnackBar();
      return;
    }

    context.read<LoginCubit>().login(
      LoginRequest(
        email: _userController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }

  Future<void> _sendOtp() async {
    if (!(_otpFormKey.currentState?.validate() ?? false)) return;

    // ── network check ──────────────────────────────────────
    if (!await _hasNetwork()) {
      _showNoNetworkSnackBar();
      return;
    }

    context.read<LoginCubit>().loginWithSms(_nationalIdController.text.trim());
  }

  Future<void> _verifyOtp() async {
    if (!(_otpFormKey.currentState?.validate() ?? false)) return;

    // ── network check ──────────────────────────────────────
    if (!await _hasNetwork()) {
      _showNoNetworkSnackBar();
      return;
    }

    // TODO: استبدل بـ API call للتحقق من OTP
     context.read<LoginCubit>().verifyLoginWithSms(_nationalIdController.text.trim(),_otpController.text.trim());
  }

  // ─────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final isArabic = LocalizationService.getLang() == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            // ── Password Login ─────────────────────────────
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(" تم تسجيل الدخول بنجاح "),
                  backgroundColor: const Color(0xFF86896E),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(
                        state.isNoInternet
                            ? Icons.wifi_off_rounded
                            : state.isUnauthorized
                            ? Icons.lock_outline_rounded
                            : state.isServerError
                            ? Icons.cloud_off_rounded
                            : Icons.error_outline_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(state.message)),
                    ],
                  ),
                  backgroundColor: state.isNoInternet
                      ? Colors.orange
                      : state.isUnauthorized
                      ? Colors.deepOrange
                      : Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: state.isNoInternet ? 4 : 3),
                ),
              );
            }

            // ── SMS / OTP ──────────────────────────────────
            if (state is LoginSmsSuccess) {
              // هنا فقط لما يُرسل OTP بنجاح
              setState(() {
                _otpStep = _OtpStep.enterOtp;
                _otpFormKey = GlobalKey<FormState>();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: const Color(0xFF86896E),
                  behavior: SnackBarBehavior.floating,
                ),
              );

            } else if (state is VerifyLoginSmsSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("تم تسجيل الدخول بنجاح"),
                  backgroundColor: const Color(0xFF86896E),
                  behavior: SnackBarBehavior.floating,
                ),
              );

              // استخدم addPostFrameCallback للتأكد أن الـ Navigator يشتغل بعد تحديث الـ widget tree
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              });
            } else if (state is LoginSmsFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(
                        state.isNoInternet
                            ? Icons.wifi_off_rounded
                            : state.isUnauthorized
                            ? Icons.lock_outline_rounded
                            : state.isServerError
                            ? Icons.cloud_off_rounded
                            : Icons.error_outline_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(state.message)),
                    ],
                  ),
                  backgroundColor: state.isNoInternet
                      ? Colors.orange
                      : state.isUnauthorized
                      ? Colors.deepOrange
                      : Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: state.isNoInternet ? 4 : 3),
                ),
              );
            }
          },
          builder: (context, state) {
            // ── determine loading per mode ─────────────────
            final isLoading = state is LoginLoading || state is LoginSmsLoading;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Logo ───────────────────────────────────
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

                  // ── White Card ─────────────────────────────
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

                        // ── Page Title ────────────────────────
                        Text(
                          "login".tr(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ── Mode Toggle ───────────────────────
                        _ModeToggle(current: _mode, onChanged: _switchMode),
                        const SizedBox(height: 24),

                        // ── Form (animated switch) ────────────
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
                                  formKey: _passwordFormKey,
                                  userController: _userController,
                                  passwordController: _passwordController,
                                  isArabic: isArabic,
                                  rememberMe: _rememberMe,
                                  loading: isLoading,
                                  onRememberMe: (v) =>
                                      setState(() => _rememberMe = v ?? false),
                                  onLogin: _loginWithPassword,
                                )
                              : _OtpForm(
                                  key: ValueKey(_otpStep),
                                  formKey: _otpFormKey,
                                  step: _otpStep,
                                  nationalIdController: _nationalIdController,
                                  otpController: _otpController,
                                  isArabic: isArabic,
                                  loading: isLoading,
                                  onSendOtp: _sendOtp,
                                  onVerify: _verifyOtp,
                                  onChangeId: _onChangeId,
                          ),
                        ),

                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
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
  const _ToggleBtn({
    required this.label,
    required this.active,
    required this.onTap,
  });

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
  final GlobalKey<FormState> formKey;
  final TextEditingController userController;
  final TextEditingController passwordController;
  final bool isArabic;
  final bool rememberMe;
  final bool loading;
  final ValueChanged<bool?> onRememberMe;
  final VoidCallback onLogin;

  const _PasswordForm({
    super.key,
    required this.formKey,
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
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("username_label".tr(), style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          CustomTextField(
            hintText: "username_hint".tr(),
            controller: userController,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return "username_required".tr();
              }
              if (v.trim().length < 3) {
                return "username_min_length".tr();
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          Text("password_label".tr(), style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          CustomTextField(
            hintText: "password_hint".tr(),
            isPassword: true,
            controller: passwordController,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return "password_required".tr();
              }
              if (v.trim().length < 6) {
                return "password_min_length".tr();
              }
              return null;
            },
          ),
          const SizedBox(height: 10),

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
                  Text(
                    "remember_me".tr(),
                    style: const TextStyle(fontSize: 12),
                  ),
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

          loading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFF86896E)),
                )
              : CustomButton(text: "login".tr(), onPressed: onLogin),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  OTP FORM  –  State 2 & 3
// ══════════════════════════════════════════════════════════════
class _OtpForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
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
    required this.formKey,
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
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("national_id_label".tr(), style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          CustomTextField(
            hintText: "national_id_hint".tr(),
            controller: nationalIdController,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            keyboardType: TextInputType.number,
            readOnly: step == _OtpStep.enterOtp,
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return "national_id_required".tr();
              }
              if (v.trim().length != 10) {
                return "national_id_invalid".tr(); // رقم الهوية 10 أرقام
              }
              if (!RegExp(r'^\d+$').hasMatch(v.trim())) {
                return "national_id_numbers_only".tr();
              }
              return null;
            },
          ),

          if (step == _OtpStep.enterOtp) ...[
            const SizedBox(height: 20),
            Text("otp_label".tr(), style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: "otp_hint".tr(),
              controller: otpController,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return "otp_required".tr();
                }
                if (v.trim().length != 6) {
                  return "otp_invalid_length".tr(); // OTP 6 أرقام
                }
                if (!RegExp(r'^\d+$').hasMatch(v.trim())) {
                  return "otp_numbers_only".tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 8),

            Align(
              alignment: isArabic
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
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

          loading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFF86896E)),
                )
              : CustomButton(
                  text: step == _OtpStep.enterNationalId
                      ? "send_otp".tr()
                      : "verify_and_login".tr(),
                  onPressed: step == _OtpStep.enterNationalId
                      ? onSendOtp
                      : onVerify,
                ),
        ],
      ),
    );
  }
}
