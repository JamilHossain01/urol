class ApiUrl {



  static const String baseUrl = "http://10.10.10.9:4300/api";

  static const String login = "$baseUrl/auth/login";
  static const String forgetPass = "$baseUrl/auth/forgot-password";
  static const String verifyOTP = "$baseUrl/auth/verify-otp";
  static const String signUp = "$baseUrl/auth/create";
  static const String resetPassword = "$baseUrl/auth/reset-password";

  // profile
  static const String profile = "$baseUrl/user/profile";


  static String reviewStatistics({required String serviceId}) =>
      "$baseUrl/reviews/stats/$serviceId";


}
