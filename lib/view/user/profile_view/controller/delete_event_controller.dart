// ignore_for_file: avoid_print

import 'package:calebshirthum/uitilies/custom_toast.dart';
import 'package:calebshirthum/view/user/profile_view/controller/my_events_controller.dart';
import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/my_gyms_model.dart';
import 'my_gym_controller.dart';

class DeleteEventController extends GetxController {
  var isLoading = false.obs;

  final MyEventsController _myEventsController = Get.put(MyEventsController());

  @override
  void onInit() {
    super.onInit();
  }

  void deleteGyms({required dynamic eventId}) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.deleteRequest(
            api: ApiUrl.deleteEvent(eventId: eventId)),
      );

      if (responseBody['success'] == true) {
        CustomToast.showToast("Event Delete Successfully Done", isError: false);
        _myEventsController.getMyEvents();
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
