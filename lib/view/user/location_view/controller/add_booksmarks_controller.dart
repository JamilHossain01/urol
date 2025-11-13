// ignore_for_file: avoid_print

import 'package:calebshirthum/uitilies/custom_toast.dart';
import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import 'gym_details_controller.dart';

class AddGymBookMarksController extends GetxController {
  var isLoading = false.obs;

  final GetGymDetailsController _getGymDetailsController =
      Get.put(GetGymDetailsController());

  @override
  void onInit() {
    super.onInit();
  }

  void addGym({required dynamic gymId}) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: ApiUrl.addGymBookmarks(), body: {"gym": gymId}),
      );

      if (responseBody['success'] == true) {
        CustomToast.showToast("Gym Bookmarked Successfully", isError: false);
        _getGymDetailsController.getGymDetails(gymId: gymId);
      } else {
        // Show error toast instead of throwing
        CustomToast.showToast(
          responseBody['message'] ?? "Failed to add gym",
          isError: true,
        );
        print("ErrorResponse: $responseBody");
      }
    } catch (e) {
      CustomToast.showToast(
        "$e",
        isError: true,
      );
      print("Error loading profile: $e");
    } finally {
      isLoading(false);
    }
  }
}
