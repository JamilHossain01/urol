// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/discover_friend_model.dart';

class DiscoverFriendsController extends GetxController {
  var isLoading = false.obs;
  var friend = DiscoverFriendsModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getDiscover(String? searchTerm) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
            api: ApiUrl.discoverFriends(
                searchTerm: searchTerm!, limit: '9999999')),
      );

      if (responseBody['success'] == true) {
        friend.value = DiscoverFriendsModel.fromJson(responseBody);
        print("fetched: ${friend.value}");
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
