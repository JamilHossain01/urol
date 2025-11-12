// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:calebshirthum/common%20widget/success_screen_widget.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/view/user/dashboard_view/bottom_navigation_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/local_storage.dart';
import '../../../../uitilies/custom_toast.dart';

class EditEventController extends GetxController {
  var isLoading = false.obs;

  Future<void> updateEvent({
    required String name,
    required String street,
    required String state,
    required String city,
    required String gymId,
    required String zipCode,
    required String phone,
    required String email,
    required String website,
    required String type,
    required String date,
    required String eventId,
    required dynamic registrationFee,
    File? image, // allow null
  }) async {
    try {
      isLoading(true);

      final uri = Uri.parse(ApiUrl.editEvent(id: eventId));
      final storage = StorageService();
      final accessToken = storage.read<String>('accessToken');

      var request = http.MultipartRequest('PATCH', uri);

      if (accessToken != null && accessToken.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $accessToken';
      }

      final Map<String, dynamic> payload = {
        "type": type,
        "gym": gymId,
        "name": name,
        "venue": street,
        "state": state,
        "city": city,
        "zip_code": zipCode,
        "phone": phone,
        "email": email,
        "event_website": website,
        "date": date,
        "registration_fee": registrationFee,
      };

      request.fields['data'] = jsonEncode(payload);

      if (image != null && await image.exists()) {
        request.files
            .add(await http.MultipartFile.fromPath('image', image.path));
        print("📸 New image added: ${image.path}");
      } else {
        print("🟡 No new image selected, keeping existing one");
      }

      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      print("📡 Status Code: ${streamedResponse.statusCode}");
      print("📄 Response Body: $responseBody");

      if (streamedResponse.statusCode == 200 ||
          streamedResponse.statusCode == 201) {
        CustomToast.showToast("Event edited successfully!", isError: false);

        Get.offAll(() => SuccessScreen(
              title: "Event Edit Success",
              message:
                  "Your event was updated successfully.\nYou can find it in the 'My Events' section.",
              buttonText: "Back to Home",
              onPressed: () {
                Get.offAll(() => DashboardView());
              },
              buttonColor: AppColors.mainColor,
            ));
      } else {
        final errorData = jsonDecode(responseBody);
        final msg = errorData['message'] ??
            errorData['error'] ??
            'Server error: ${streamedResponse.statusCode}';
        CustomToast.showToast(msg, isError: true);
      }
    } catch (e) {
      print("❌ updateEvent error: $e");
      CustomToast.showToast(e.toString(), isError: true);
    } finally {
      isLoading(false);
    }
  }
}
