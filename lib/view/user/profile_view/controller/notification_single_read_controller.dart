// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/my_events_model.dart' show MyEventsModel;
import '../model/notification_model.dart';
import 'get_all_notification_controller.dart';

class GetReadAllNotificationController extends GetxController {
  var isLoading = false.obs;
  var notification = NotificationModel().obs;

  final GetAllNotificationController _controller =
      Get.put(GetAllNotificationController());

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getRead({required notificationId}) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.putRequest(
            api: ApiUrl.readNotificationSingle(id: notificationId), body: {}),
      );

      if (responseBody['success'] == true) {
        notification.value = NotificationModel.fromJson(responseBody);
        print("fetched: ${notification.value}");
        _controller.getNotification();
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
