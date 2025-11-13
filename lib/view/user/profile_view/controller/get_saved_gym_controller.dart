// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/saved_gym_model.dart';

class GetSavedGymController extends GetxController {
  var isLoading = false.obs;
  var gums = SavedGymModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getSavedGym() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.savedGym),
      );

      if (responseBody['success'] == true) {
        gums.value = SavedGymModel.fromJson(responseBody);
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
