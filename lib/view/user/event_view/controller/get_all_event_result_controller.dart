// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/get_all_event_model.dart';

class GetAllEventResultController extends GetxController {
  var isLoading = false.obs;
  var profile = CompetitionModel().obs;

  @override
  void onInit() {
    super.onInit();
    getAllEventResult();
  }

  void getAllEventResult() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.getAllEventResult),
      );

      if (responseBody['success'] == true) {
        profile.value = CompetitionModel.fromJson(responseBody);
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
