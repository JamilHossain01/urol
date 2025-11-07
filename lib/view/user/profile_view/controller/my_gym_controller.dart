// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/my_gyms_model.dart';

class MyGymController extends GetxController {
  var isLoading = false.obs;
  var friend = MyGymsModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getMyGyms(String? searchTerm) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.myGyms),
      );

      if (responseBody['success'] == true) {
        friend.value = MyGymsModel.fromJson(responseBody);
        print("fetched: ${friend.value}");
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
