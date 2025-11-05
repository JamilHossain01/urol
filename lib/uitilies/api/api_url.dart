class ApiUrl {
  static const String baseUrl = "http://10.10.10.9:4300/api";

  static const String login = "$baseUrl/auth/login";
  static const String forgetPass = "$baseUrl/auth/forgot-password";
  static const String verifyOTP = "$baseUrl/auth/verify-otp";
  static const String signUp = "$baseUrl/auth/create";
  static const String resetPassword = "$baseUrl/auth/reset-password";
  static const String updateProfile = "$baseUrl/users/update-my-profile";
  static const String support = "$baseUrl/contacts/add";
  static const String changePassword = "$baseUrl/auth/change-password";

  // profile
  static const String profile = "$baseUrl/users/my-profile";

  static String reviewStatistics({required String serviceId}) =>
      "$baseUrl/reviews/stats/$serviceId";

  static String settingMetaData({required String meta}) =>
      "$baseUrl/setting/$meta";
}
