// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/local_storage.dart';
import '../../../../uitilies/custom_toast.dart';
import '../../dashboard_view/bottom_navigation_view.dart';

class EditGymController extends GetxController {
  var isLoading = false.obs;

  Future<void> editGym({
    required String name,
    required String gymId,
    required String description,
    required String street,
    required String state,
    required String apartment,
    required String city,
    required String zipCode,
    required String phone,
    required String email,
    required String website,
    required String facebook,
    required String instagram,
    required dynamic latitude,
    required dynamic longitude,
    required List<String> disciplines,
    required List<Map<String, dynamic>> matSchedules,
    required List<Map<String, dynamic>> classSchedules,
    required List<File> newImages,
    required List<String> existingImages, // <-- NEW
  }) async {
    try {
      isLoading(true);

      final uri = Uri.parse(ApiUrl.editGym(id: gymId));
      final storage = StorageService();
      final accessToken = storage.read<String>('accessToken');

      var request = http.MultipartRequest('PATCH', uri);

      if (accessToken != null && accessToken.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $accessToken';
      }

      // ---- Payload with existing images ----
      final Map<String, dynamic> payload = {
        "name": name,
        "description": description,
        "street": street,
        "state": state,
        "city": city,
        "zip_code": zipCode,
        "apartment": apartment,
        "phone": phone,
        "email": email,
        "website": website,
        "facebook": facebook,
        "instagram": instagram,
        "mat_schedules": matSchedules,
        "class_schedules": classSchedules,
        "disciplines": disciplines,
        "images": existingImages,
        "location": {
          "coordinates": [longitude, latitude]
        }
      };

      request.fields['data'] = jsonEncode(payload);
      print("📦 Gym Payload: ${jsonEncode(payload)}");

      // ---- Attach new images ----
      for (var i = 0; i < newImages.length; i++) {
        final file = await http.MultipartFile.fromPath(
          'images',
          newImages[i].path,
          filename: newImages[i].path.split('/').last,
        );
        request.files.add(file);
        print("📸 Attached new image: ${file.filename}");
      }

      // ---- Send request ----
      print("🚀 Sending PATCH to $uri");
      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      print("📡 Status Code: ${streamedResponse.statusCode}");
      print("📄 Response Body: $responseBody");

      // ---- Handle response ----
      if (streamedResponse.statusCode == 200 ||
          streamedResponse.statusCode == 201) {
        CustomToast.showToast("Gym updated successfully!", isError: false);
        Get.back();
      } else {
        Map<String, dynamic> errorData = {};
        try {
          errorData = jsonDecode(responseBody);
        } catch (_) {
          errorData = {'message': 'Unknown server error'};
        }
        final msg = errorData['message'] ??
            errorData['error'] ??
            'Server error: ${streamedResponse.statusCode}';
        CustomToast.showToast(msg, isError: true);
      }
    } catch (e) {
      print("❌ EditGymController error: $e");
      CustomToast.showToast(e.toString(), isError: true);
    } finally {
      isLoading(false);
    }
  }
}
