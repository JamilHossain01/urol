// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/unread_notification_model.dart';

class UnreadNotificationController extends GetxController {
  var isLoading = false.obs; // used internally, not for UI
  var unread = NotificationUnreadModel().obs;

  @override
  void onInit() {
    super.onInit();
    getUnReadController();
  }

  void getUnReadController() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.notificationUnread),
      );

      if (responseBody['success'] == true) {
        unread.value = NotificationUnreadModel.fromJson(responseBody);
        print("fetched: ${unread.value}");
      } else {
        print('Failed to load: ${responseBody['message']}');
      }
    } catch (e) {
      print("Error loading notifications: $e");
    } finally {
      isLoading(false);
    }
  }
}

