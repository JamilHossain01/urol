// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, prefer_const_constructors

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/local_storage.dart';
import '../../../uitilies/custom_toast.dart';
import '../otp_verify_filed_view.dart';

class ForgotPasswordController extends GetxController {
  var isLoading = false.obs;

  final StorageService _storageService = StorageService();

  Future<void> emailSubmit({required dynamic email}) async {
    try {
      isLoading(true);

      var map = {"email": email};

      print("Request Body: $map");

      var response = await http.post(
        Uri.parse(ApiUrl.forgetPass),
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode(map),
      );

      print("🔐 OTP Response: ${response.body}");

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 && responseBody['success'] == true) {
        String token = responseBody['data']['token'];
        await _storageService.write('token', token);

        CustomToast.showToast('✅ Now please enter your OTP', isError: false);

        Get.offAll(() => OTPVerifyView(
              email: email,
            ));
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

        CustomToast.showToast("$errorMessage", isError: true);
      }
    } catch (e) {
      CustomToast.showToast("Something went wrong: $e", isError: true);
      print("❗ Exception: $e");
    } finally {
      isLoading(false);
    }
  }
}
