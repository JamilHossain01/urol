import 'dart:convert';
import 'package:calebshirthum/view/auth_view/login_auth_view.dart';
import 'package:calebshirthum/view/user/profile_view/controller/discover_friends_controller.dart';
import 'package:get/get.dart';

import '../../../../common widget/success_screen_widget.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/custom_toast.dart';
import '../../../../view/user/dashboard_view/bottom_navigation_view.dart';

class AddFriendController extends GetxController {
  var isLoading = false.obs;

  final DiscoverFriendsController _discoverFriendsController =
      Get.put(DiscoverFriendsController());

  Future<void> addFriend({
    required String id,
  }) async {
    isLoading(true);

    Map<String, dynamic> body = {
      "friend_id": id,
    };

    try {
      print("🚀 Sending to: ${ApiUrl.support}");
      print("📦 Body: ${jsonEncode(body)}");

      var response = await BaseClient.postRequest(
        api: ApiUrl.addFriend,
        body: body,
      );

      print("📡 Status: ${response.statusCode}");
      print("📄 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        _discoverFriendsController.getDiscover('');

        CustomToast.showToast(
          "Friend successfully added!",
          isError: false,
        );
      } else {
        Map<String, dynamic> errorData = {};
        try {
          errorData = jsonDecode(response.body);
        } catch (e) {
          errorData = {'message': 'Unknown server error'};
        }

        String errorMsg = errorData['message'] ??
            errorData['error'] ??
            errorData['detail'] ??
            'Server error: ${response.statusCode}';

        throw Exception(errorMsg);
      }
    } catch (e) {
      print("❌ Error sending support message: $e");

      String errorMsg = e.toString().replaceFirst('Exception: ', '');
      CustomToast.showToast(errorMsg, isError: true);
    } finally {
      isLoading(false);
    }
  }
}
