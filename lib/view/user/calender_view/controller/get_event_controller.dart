// ignore_for_file: avoid_print

import 'package:calebshirthum/view/user/calender_view/model/event_model.dart';
import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';

class GetEventController extends GetxController {
  var isLoading = false.obs;
  var allEvent = AllEventModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getAllEvent(
      String searchTerms, String type, String state, String city) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
            api: ApiUrl.allEvent(
                searchTerm: searchTerms, type: type, state: state, city: '')),
      );

      if (responseBody['success'] == true) {
        allEvent.value = AllEventModel.fromJson(responseBody);
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
