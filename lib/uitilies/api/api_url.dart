class ApiUrl {
  // static const String baseUrl = "http://10.10.10.3:5000/api/v1";
  static const String socketGlobal = "https://renti-socket.techcrafters.tech";
  static String imageUrl({String? url}) {
    return "http://192.168.10.5:5005/$url";
  }

  static String socketURL = "http://115.127.156.14:5006";
  static const String login = "$baseUrl/auth/sign-in";
  static const String forgetPass = "$baseUrl/auth/forget-password";
  static const String verifyOTP = "$baseUrl/auth/verify-account";
  static const String signUp = "$baseUrl/auth/sign-up";
  static const String resetPassword = "$baseUrl/auth/reset-password";

  // profile
  static const String profile = "$baseUrl/user/profile";


  static String reviewStatistics({required String serviceId}) =>
      "$baseUrl/reviews/stats/$serviceId";
  static const String baseUrl = "https://www.api.amipeta.lt/api/v1";
  static const String googleLogin = "$baseUrl/auth/social-login";

}
