// ignore_for_file: avoid_print

import 'package:calebshirthum/uitilies/custom_toast.dart';
import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/my_gyms_model.dart';
import 'my_gym_controller.dart';

class DeleteGymController extends GetxController {
  var isLoading = false.obs;
  var gums = MyGymsModel().obs;

  final MyGymController _myGymController = Get.put(MyGymController());

  @override
  void onInit() {
    super.onInit();
  }

  void deleteGyms({required dynamic gymId}) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.deleteRequest(api: ApiUrl.deleteGym(gymId: gymId)),
      );

      if (responseBody['success'] == true) {

        CustomToast.showToast("Gym Delete Successfully Done", isError: false);
        _myGymController.getMyGyms();

        print("fetched: ${gums.value}");
      } else {
        throw 'Failed to load profile data: ${responseBody['message']}';
      }
    } catch (e) {
      print("Error loading profile: $e");
    } finally {
      isLoading(false);
    }
  }
}
