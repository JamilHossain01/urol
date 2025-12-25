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
    return null; // Valid
  }
}