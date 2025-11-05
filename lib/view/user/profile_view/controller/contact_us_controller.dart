import 'dart:convert';
import 'package:get/get.dart';

import '../../../../common widget/success_screen_widget.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/custom_toast.dart';
import '../../../../view/user/dashboard_view/bottom_navigation_view.dart';

class ContactUsController extends GetxController {
  var isLoading = false.obs;

  Future<void> addReflection({
    required String name,
    required String email,
    required String description,
  }) async {
    isLoading(true);

    Map<String, dynamic> body = {
      "name": name.trim(),
      "email": email.trim(),
      "description": description.trim(),
    };

    try {
      print("🚀 Sending to: ${ApiUrl.support}");
      print("📦 Body: ${jsonEncode(body)}");

      var response = await BaseClient.postRequest(
        api: ApiUrl.support,
        body: body,
      );

      print("📡 Status: ${response.statusCode}");
      print("📄 Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        CustomToast.showToast(
          "Your support message has been sent successfully!",
          isError: false,
        );

        Get.off(() => SuccessScreen(
          title: "Thank You, $name!",
          message:
          "We have received your message and will get back to you at $email within 24 hours.",
          buttonText: "Back to Home",
          buttonColor: AppColors.mainColor,
          onPressed: () {
            Get.offAll(() => DashboardView());
          },
        ));
      } else {
        // Parse error response
        Map<String, dynamic> errorData = {};
        try {
          errorData = jsonDecode(response.body);
        } catch (e) {
          errorData = {'message': 'Unknown server error'};
        }

        String errorMsg = errorData['message'] ??
            errorData['error'] ??
            errorData['detail'] ??
            'Server error: ${response.statusCode}';

        throw Exception(errorMsg);
      }
    } catch (e) {
      print("❌ Error sending support message: $e");

      String errorMsg = e.toString().replaceFirst('Exception: ', '');
      CustomToast.showToast(errorMsg, isError: true);
    } finally {
      isLoading(false);
    }
  }
}