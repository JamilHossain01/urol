import 'dart:convert';
import 'package:calebshirthum/view/auth_view/login_auth_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/local_storage.dart';
import '../../../uitilies/custom_toast.dart';
import '../create_new_password_view.dart';

class OTPController extends GetxController {
  var isLoading = false.obs;

  final StorageService _storageService = StorageService();

  Future<void> otpSubmit({required dynamic otp, required bool redirect}) async {
    try {
      isLoading(true);

      final otpToken = await _storageService.read("token");
      var map = {"otp": otp};

      print("Request Body: $map");
      print("otp token $otpToken");

      var response = await http.post(
        Uri.parse(ApiUrl.verifyOTP),
        headers: {
          "token": otpToken,
          "content-type": "application/json",
        },
        body: jsonEncode(map),
      );

      print("🔐 OTP Response: ${response.body}");

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 && responseBody['success'] == true) {
        if (redirect) {
          Get.to(() => SignInView());
          CustomToast.showToast('✅ Now please login', isError: false);
        } else {
          Get.to(() => CreateNewPasswordView());
          CustomToast.showToast('✅ Now create your Password ', isError: false);
        }
      } else {
        String errorMessage =
            responseBody['message'] ?? 'OTP verification failed.';

        if (responseBody['errorSources'] != null &&
            responseBody['errorSources'] is List &&
            responseBody['errorSources'].isNotEmpty) {
          errorMessage =
              responseBody['errorSources'][0]['message'] ?? errorMessage;
        } else if (responseBody['err']?['issues'] != null &&
            responseBody['err']['issues'] is List &&
            responseBody['err']['issues'].isNotEmpty) {
          errorMessage =
              responseBody['err']['issues'][0]['message'] ?? errorMessage;
        }

        CustomToast.showToast("❌ $errorMessage", isError: true);
      }
    } catch (e) {
      CustomToast.showToast("Something went wrong: $e", isError: true);
      print("❗ Exception: $e");
    } finally {
      isLoading(false);
    }
  }
}
