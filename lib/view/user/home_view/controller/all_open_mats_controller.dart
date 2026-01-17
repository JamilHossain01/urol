// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/all_open_mats_model.dart';
import '../model/unread_notification_model.dart';

class GetAllOpenMatsController extends GetxController {
  var isLoading = false.obs;
  var unread = AllOpenMatsModel().obs;
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   getAllMats();
  // }

  Future<void> getAllMats({required dynamic lat, required dynamic long}) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
            api: ApiUrl.allOpenMats(lat: lat, long: long)),
      );

      if (responseBody['success'] == true) {
        unread.value = AllOpenMatsModel.fromJson(responseBody);
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
