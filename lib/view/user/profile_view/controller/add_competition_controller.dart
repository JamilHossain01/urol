import 'dart:convert';
import 'package:calebshirthum/view/user/home_view/controller/my_profile_controller.dart';
import 'package:get/get.dart';
import '../../../../common widget/success_screen_widget.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/custom_toast.dart';
import '../../../../view/user/dashboard_view/bottom_navigation_view.dart';

class AddCompetitionController extends GetxController {
  var isLoading = false.obs;


  final GetProfileController _profileController = Get.put(GetProfileController());

  Future<void> addCompetition({
    required String eventName,
    required String eventDate,
    required String division,
    required String state,
    required String city,
    required String result,
  }) async {
    isLoading(true);

    Map<String, dynamic> body = {
      "event_name": eventName,
      "event_date": eventDate,
      "division": division,
      "state": state,
      "city": city,
      "result": result
    };

    try {
      print("🚀 Sending to: ${ApiUrl.competition}");
      print("📦 Body: ${jsonEncode(body)}");

      var response = await BaseClient.postRequest(
        api: ApiUrl.competition,
        body: body,
      );

      print("📡 Status: ${response.statusCode}");
      print("📄 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        CustomToast.showToast(
          "Competition added successfully!",
          isError: false,
        );

        Get.offAll(
          () => SuccessScreen(
            title: "Success!",
            message:
                "Your competition result has been added successfully. You can now view it in your profile section.",
            buttonText: "Go to Dashboard",
            buttonColor: AppColors.mainColor,
            onPressed: () {

              _profileController.getProfileController();

              Get.offAll(() => DashboardView());
            },
          ),
        );
      } else {
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
      print("❌ Error sending competition result: $e");

      String errorMsg = e.toString().replaceFirst('Exception: ', '');
      CustomToast.showToast(errorMsg, isError: true);
    } finally {
      isLoading(false);
    }
  }
}
