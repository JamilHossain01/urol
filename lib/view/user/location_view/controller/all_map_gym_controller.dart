// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/all_map_gym_model.dart';

class AllMapGymController extends GetxController {
  var isLoading = false.obs;
  var profile = AllMapGymModel().obs;

  void getAllMapGym(
      {required dynamic distance,
      required String searchTerm,
      required String disciplines}) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
            api: ApiUrl.mapGym(
                searchTerm: searchTerm,
                distance: distance ?? 0,
                disciplines: disciplines)),
      );

      if (responseBody['success'] == true) {
        profile.value = AllMapGymModel.fromJson(responseBody);
        print("fetched: ${profile.value}");
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
