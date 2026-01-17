import 'dart:convert';
import 'package:calebshirthum/view/user/home_view/controller/my_profile_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/local_storage.dart';
import '../../../uitilies/custom_toast.dart';
import '../../user/dashboard_view/enable_location_view.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final StorageService _storageService = StorageService();

  final GetProfileController _getProfileController =
      Get.put(GetProfileController());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading(true);

      final fcmToken = await _storageService.read('fcmToken');

      var map = <String, dynamic>{
        "email": email,
        "password": password,
        "fcmToken": fcmToken,
      };

      print("Request Body: $map");

      var response = await http.post(
        Uri.parse(ApiUrl.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(map),
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['success'] == true) {
          String accessToken = responseBody['data']['accessToken'];
          String id = responseBody['data']['user']['_id'];

          await _storageService.write('accessToken', accessToken);
          await _storageService.write('_id', id);

          Get.offAll(() => EnableLocationView());

          _getProfileController.getProfileController();

          CustomToast.showToast("Login successful!");
        } else {
          String errorMessage =
              responseBody['message'] ?? 'Login failed. Please try again.';

          if (responseBody['errorSources'] != null &&
              responseBody['errorSources'] is List) {
            List errorSources = responseBody['errorSources'];
            errorMessage = errorSources
                .map((e) => e['message'] ?? '')
                .where((msg) => msg.isNotEmpty)
                .join('\n');
          }

          CustomToast.showToast(errorMessage, isError: true);
        }
      } else {
        var responseBody = jsonDecode(response.body);
        String errorMessage = "Invalid Credentials";

        if (responseBody['message'] != null) {
          errorMessage = responseBody['message'];
        }

        CustomToast.showToast(errorMessage, isError: true);
      }
    } catch (e) {
      CustomToast.showToast("Something went wrong: $e", isError: true);
    } finally {
      isLoading(false);
    }
  }
}
