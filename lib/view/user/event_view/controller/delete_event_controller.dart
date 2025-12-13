// ignore_for_file: avoid_print

import 'package:calebshirthum/uitilies/custom_toast.dart';
import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/get_all_event_model.dart';
import 'get_all_event_result_controller.dart';

class DeleteResultEventController extends GetxController {
  var isLoading = false.obs;
  var gums = CompetitionModel().obs;

  final GetAllEventResultController _getAllEventResultController =
      Get.put(GetAllEventResultController());

  @override
  void onInit() {
    super.onInit();
  }

  void deleteResultEvent({required dynamic eventResultId}) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.deleteRequest(
            api: ApiUrl.eventResultDelete(eventResultId: eventResultId)),
      );

      if (responseBody['success'] == true) {
        CustomToast.showToast("Event Result Delete Successfully Done",
            isError: false);
        _getAllEventResultController.getAllEventResult();

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
