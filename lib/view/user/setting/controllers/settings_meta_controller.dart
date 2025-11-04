// ignore_for_file: avoid_print

import 'package:get/get.dart';

import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/settings_meta_data_model.dart';

class SettingsMetaDataController extends GetxController {
  var isLoading = false.obs;
  var profile = SettingsMetaDataModel().obs;

  @override
  void onInit() {
    getTerms();
    super.onInit();
  }

  void getTerms({String? meta}) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.settingMetaData(meta: meta!)),
      );

      if (responseBody['success'] == true) {
        profile.value = SettingsMetaDataModel.fromJson(responseBody);
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
