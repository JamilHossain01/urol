// ignore_for_file: avoid_print

import 'package:calebshirthum/uitilies/custom_toast.dart';
import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/my_events_model.dart' show MyEventsModel;
import 'get_all_notification_controller.dart';

class AllNotificationReadController extends GetxController {
  var isLoading = false.obs;

  final GetAllNotificationController _controller =
      Get.put(GetAllNotificationController());

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getReadAll() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.putRequest(api: ApiUrl.allNotificationRead, body: {}),
      );

      if (responseBody['success'] == true) {
        _controller.getNotification();
        CustomToast.showToast("All notification read successfully done",
            isError: false);
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
