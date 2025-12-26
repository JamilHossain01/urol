/// Reusable USA Phone Validator class
class PhoneValidator {
  /// Validates a USA phone number.
  /// Returns `null` if valid, or the error string if invalid.
  static String? validate(String value) {
    // Remove spaces, dashes, parentheses
    final sanitized = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    if (sanitized.isEmpty) {
      return "Phone number is required";
    } else if (!RegExp(r'^\d{10}$').hasMatch(sanitized)) {
      return "Enter a valid 10-digit USA phone number";
    }
    return null;
  }
}


class PhoneFormatter {
  /// Formats a 10-digit USA phone number to (XXX) XXX-XXXX
  static String format(String value) {
    // Remove everything except digits
    final digits = value.replaceAll(RegExp(r'\D'), '');

    if (digits.length != 10) {
      return value; // return original if not 10 digits
    }

    return '(${digits.substring(0, 3)}) '
        '${digits.substring(3, 6)}-'
        '${digits.substring(6)}';
  }
}
