// ignore_for_file: avoid_print

import 'package:calebshirthum/view/user/calender_view/model/event_model.dart';
import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/gym_details_model.dart';

class GetGymDetailsController extends GetxController {
  var isLoading = false.obs;
  var allEvent = GymDetailsModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getGymDetails({
    required String gymId,
  }) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.gymDetails(gymId: gymId)),
      );

      if (responseBody['success'] == true) {
        allEvent.value = GymDetailsModel.fromJson(responseBody);
        print("fetched: ${allEvent.value}");
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
