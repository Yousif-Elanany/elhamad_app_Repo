enum ValidationRule {
  email,
  password,
  confirmPassword,
  phone, required,
}

class SmartValidator {
  static String? validate(
      String? value, {
        String fieldName = "الحقل",
        List<ValidationRule>? rules,

        /// 🔥 افتراضي: مطلوب
        bool required = true,

        /// phone
        String? countryCode,

        /// password
        int minPasswordLength = 8,
        String? originalPassword,
      }) {
    // ================= REQUIRED =================
    if (required && (value == null || value.trim().isEmpty)) {
      return "$fieldName مطلوب";
    }

    // لو مش مطلوب وفاضي → تمام
    if (!required && (value == null || value.trim().isEmpty)) {
      return null;
    }

    for (final rule in rules ?? []) {
      switch (rule) {
        case ValidationRule.email:
          if (!_emailRegex.hasMatch(value!)) {
            return "صيغة $fieldName غير صحيحة";
          }
          break;

        case ValidationRule.password:
          if (value!.length < minPasswordLength) {
            return "$fieldName لا يقل عن $minPasswordLength حروف";
          }
          if (!RegExp(r'[A-Z]').hasMatch(value)) {
            return "يجب أن يحتوي $fieldName على حرف كبير";
          }
          if (!RegExp(r'[a-z]').hasMatch(value)) {
            return "يجب أن يحتوي $fieldName على حرف صغير";
          }
          if (!RegExp(r'[0-9]').hasMatch(value)) {
            return "يجب أن يحتوي $fieldName على رقم";
          }
          break;

        case ValidationRule.confirmPassword:
          if (value != originalPassword) {
            return "كلمة المرور غير متطابقة";
          }
          break;

        case ValidationRule.phone:
          final detectedCountry =
              countryCode ?? _detectCountryFromPhone(value!);
          if (!_validateArabicPhone(value??"", detectedCountry)) {
            return "رقم $fieldName غير صحيح";
          }
          break;
      }
    }

    return null;
  }

  // ================= HELPERS =================

  static final _emailRegex =
  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static bool _validateArabicPhone(
      String phone,
      String? countryCode,
      ) {
    final value =
    phone.replaceAll(RegExp(r'[^\d+]'), '');

    final patterns = <String, RegExp>{
      "EG": RegExp(r'^(\+20|0)?1[0-2,5][0-9]{8}$'),
      "SA": RegExp(r'^(\+966|0)?5[0-9]{8}$'),
      "AE": RegExp(r'^(\+971|0)?5[0-9]{8}$'),
      "KW": RegExp(r'^(\+965)?[569][0-9]{7}$'),
      "QA": RegExp(r'^(\+974)?[3567][0-9]{7}$'),
      "BH": RegExp(r'^(\+973)?[36][0-9]{7}$'),
      "OM": RegExp(r'^(\+968)?9[0-9]{7}$'),
      "JO": RegExp(r'^(\+962|0)?7[7-9][0-9]{7}$'),
      "IQ": RegExp(r'^(\+964|0)?7[3-9][0-9]{8}$'),
      "MA": RegExp(r'^(\+212|0)?[5-7][0-9]{8}$'),
      "DZ": RegExp(r'^(\+213|0)?[5-7][0-9]{8}$'),
      "TN": RegExp(r'^(\+216)?[2459][0-9]{7}$'),
    };

    if (countryCode != null &&
        patterns.containsKey(countryCode)) {
      return patterns[countryCode]!.hasMatch(value);
    }

    return RegExp(r'^\+?[0-9]{8,15}$').hasMatch(value);
  }

  static String? _detectCountryFromPhone(String phone) {
    if (phone.startsWith('+20')) return "EG";
    if (phone.startsWith('+966')) return "SA";
    if (phone.startsWith('+971')) return "AE";
    if (phone.startsWith('+965')) return "KW";
    if (phone.startsWith('+974')) return "QA";
    if (phone.startsWith('+973')) return "BH";
    if (phone.startsWith('+968')) return "OM";
    if (phone.startsWith('+962')) return "JO";
    if (phone.startsWith('+964')) return "IQ";
    if (phone.startsWith('+212')) return "MA";
    if (phone.startsWith('+213')) return "DZ";
    if (phone.startsWith('+216')) return "TN";
    return null;
  }
}
