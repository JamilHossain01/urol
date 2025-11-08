// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/my_events_model.dart' show MyEventsModel;
import '../model/my_gyms_model.dart';

class MyEventsController extends GetxController {
  var isLoading = false.obs;
  var gums = MyEventsModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getMyEvents() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.myEvent),
      );

      if (responseBody['success'] == true) {
        gums.value = MyEventsModel.fromJson(responseBody);
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
