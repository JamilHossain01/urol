// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/profile_model.dart';

class GetProfileController extends GetxController {
  var isLoading = false.obs;
  var profile = MyProfileModel().obs;

  @override
  void onInit() {
    super.onInit();
    getProfileController();
  }

  void getProfileController() async {
    try {
      isLoading(true);
      final startTime = DateTime.now();

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.profile),
      );

      if (responseBody['success'] == true) {
        profile.value = MyProfileModel.fromJson(responseBody);
        print("fetched: ${profile.value}");
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
