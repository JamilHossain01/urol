// ignore_for_file: avoid_print

import 'package:calebshirthum/uitilies/custom_toast.dart';
import 'package:calebshirthum/view/user/profile_view/controller/get_saved_gym_controller.dart';
import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/my_gyms_model.dart';

class DeleteSavedController extends GetxController {
  var isLoading = false.obs;
  var gums = MyGymsModel().obs;

  final GetSavedGymController _getSavedGymController =
      Get.put(GetSavedGymController());

  @override
  void onInit() {
    super.onInit();
  }

  void deleteBookmarksGyms({required dynamic gymId}) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.deleteRequest(
          api: ApiUrl.deleteBookMarkGym(gymId: gymId),
        ),
      );

      if (responseBody['success'] == true) {
        CustomToast.showToast(
          responseBody['message'] ?? "Success",
          isError: false,
        );

        _getSavedGymController.getSavedGym();

        print("fetched: ${gums.value}");
      } else {
        throw 'Failed: ${responseBody['message']}';
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
