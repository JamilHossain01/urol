// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, prefer_const_constructors

import 'dart:convert';
import 'package:calebshirthum/view/auth_view/login_auth_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/local_storage.dart';
import '../../../uitilies/custom_toast.dart';

class CreatePasswordController extends GetxController {
  var isLoading = false.obs;

  final StorageService _storageService = StorageService();

  Future<void> createPass(
      {required dynamic newPassword, required dynamic confirmPassword}) async {
    try {
      isLoading(true);

      final otpToken = await _storageService.read("token");

      var map = {
        "newPassword": newPassword,
        "confirmPassword": confirmPassword
      };

      print("Request Body: $map");

      var response = await http.patch(
        Uri.parse(ApiUrl.resetPassword),
        headers: {"content-type": "application/json", "token": otpToken},
        body: jsonEncode(map),
      );

      print("🔐 OTP Response: ${response.body}");

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 && responseBody['success'] == true) {
        CustomToast.showToast('✅ Password Change Success', isError: false);

        Get.offAll(() => SignInView());
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
