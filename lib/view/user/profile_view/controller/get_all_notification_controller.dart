// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/my_events_model.dart' show MyEventsModel;
import '../model/notification_model.dart';

class GetAllNotificationController extends GetxController {
  var isLoading = false.obs;
  var notification = NotificationModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getNotification() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.allNotification),
      );

      if (responseBody['success'] == true) {
        notification.value = NotificationModel.fromJson(responseBody);
        print("fetched: ${notification.value}");
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
