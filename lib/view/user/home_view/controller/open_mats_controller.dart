// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/near_by_open_mats_model.dart';

class OpenMatsController extends GetxController {
  var isLoading = false.obs;
  var openMats = NearByOpenMatsModel().obs;

  void getOpenMatsController({
    required String lat,
    required String long,
    required String hour,
    required String dayName,
    required String minute,
  }) async {
    try {
      isLoading(true);

      final startTime = DateTime.now();

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: ApiUrl.getOpenMats(
            lat: lat,
            long: long,
            hour: hour,
            dayName: dayName,
            minute: minute,
          ),
        ),
      );

      if (responseBody['success'] == true) {
        openMats.value = NearByOpenMatsModel.fromJson(responseBody);
        print("fetched: ${openMats.value}");
      } else {
        throw 'Failed to load profile data: ${responseBody['message']}';
      }

      final elapsed = DateTime.now().difference(startTime).inMilliseconds;
      if (elapsed < 2000) {
        await Future.delayed(Duration(milliseconds: 2000 - elapsed));
      }
    } catch (e) {
      print("Error loading profile: $e");
    } finally {
      isLoading(false);
    }
  }
}
