import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/local_storage.dart';
import '../../../uitilies/custom_toast.dart';
import '../otp_verify_for_register.dart';

class SignUpController extends GetxController {
  var isLoading = false.obs;
  final StorageService _storageService = StorageService();

  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    try {
      isLoading(true);

      var map = <String, dynamic>{
        "first_name": firstName,
        "last_name": lastName, //optional
        "email": email,
        "password": password,
        "contact": phoneNumber //optional
      };

      print("Request Body: $map");

      var response = await http.post(
        Uri.parse(ApiUrl.signUp),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(map),
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['success'] == true) {
          String otpToken = responseBody['data']['otpToken']['token'];

          await _storageService.write('token', otpToken);

          Get.to(() => OTPVerifyForRegister(email: email,));

          CustomToast.showToast("Account successfully created!");
        } else {
          String errorMessage =
              responseBody['message'] ?? 'Login failed. Please try again.';

          if (responseBody['errorSources'] != null &&
              responseBody['errorSources'] is List) {
            List errorSources = responseBody['errorSources'];
            errorMessage = errorSources
                .map((e) => e['message'] ?? '')
                .where((msg) => msg.isNotEmpty)
                .join('\n');
          }

          CustomToast.showToast(errorMessage, isError: true);
        }
      } else {
        var responseBody = jsonDecode(response.body);
        String errorMessage = "Invalid Credentials";

        if (responseBody['message'] != null) {
          errorMessage = responseBody['message'];
        }

        CustomToast.showToast(errorMessage, isError: true);
      }
    } catch (e) {
      CustomToast.showToast("Something went wrong: $e", isError: true);
    } finally {
      isLoading(false);
    }
  }
}
