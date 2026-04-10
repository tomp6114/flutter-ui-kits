/// Reusable validators for standard form validation logic.
class FormValidator {
  FormValidator._();

  static String? required(String? value, [String message = 'This field is required']) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  static String? email(String? value, [String message = 'Enter a valid email address']) {
    if (value == null || value.trim().isEmpty) return null;
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return message;
    return null;
  }

  static String? phone(String? value, [String message = 'Enter a valid phone number']) {
    if (value == null || value.trim().isEmpty) return null;
    final regex = RegExp(r'^\+?[0-9]{7,15}$');
    if (!regex.hasMatch(value.replaceAll(RegExp(r'\s+'), ''))) return message;
    return null;
  }

  static String? minLength(String? value, int min, [String? message]) {
    if (value == null || value.isEmpty) return null;
    if (value.length < min) return message ?? 'Minimum length is $min characters';
    return null;
  }

  static String? maxLength(String? value, int max, [String? message]) {
    if (value == null || value.isEmpty) return null;
    if (value.length > max) return message ?? 'Maximum length is $max characters';
    return null;
  }

  static String? numeric(String? value, [String message = 'Value must be a number']) {
    if (value == null || value.isEmpty) return null;
    if (double.tryParse(value) == null) return message;
    return null;
  }

  static String? match(String? value, String target, [String message = 'Values do not match']) {
    if (value != target) return message;
    return null;
  }

  /// Combine multiple validators into one sequentially.
  static String? Function(String?) combine(List<String? Function(String?)> validators) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}
