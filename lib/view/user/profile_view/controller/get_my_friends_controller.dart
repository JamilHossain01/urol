// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/my_friends_model.dart';

class GetMyFriendsController extends GetxController {
  var isLoading = false.obs;
  var friend = MyFriendsModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getFriends(String? searchTerm) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
            api: ApiUrl.myFriends(
          searchTerm: searchTerm!,
        )),
      );

      if (responseBody['success'] == true) {
        friend.value = MyFriendsModel.fromJson(responseBody);
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
