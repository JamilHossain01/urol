// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/local_storage.dart';
import '../../../../uitilies/custom_toast.dart';
import '../../dashboard_view/bottom_navigation_view.dart';

class AddGymController extends GetxController {
  var isLoading = false.obs;

  Future<void> addGym({
    required String name,
    required String description,
    required String street,
    required String state,
    required String city,
    required String zipCode,
    required String phone,
    required String email,
    required String website,
    required String facebook,
    required String instagram,
    required double latitude,
    required double longitude,
    required List<String> disciplines,
    required List<Map<String, dynamic>> matSchedules,
    required List<Map<String, dynamic>> classSchedules,
    required List<File> images,
  }) async {
    try {
      isLoading(true);

      final uri = Uri.parse(ApiUrl.addGym);
      final storage = StorageService();
      final accessToken = storage.read<String>('accessToken');

      var request = http.MultipartRequest('POST', uri);

      if (accessToken != null && accessToken.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $accessToken';
      }

      final Map<String, dynamic> payload = {
        "name": name,
        "description": description,
        "street": street,
        "state": state,
        "city": city,
        "zip_code": zipCode,
        "phone": phone,
        "email": email,
        "website": website,
        "facebook": facebook,
        "instagram": instagram,
        "mat_schedules": matSchedules,
        "class_schedules": classSchedules,
        "disciplines": disciplines,
        "location": {
          "coordinates": [longitude, latitude]
        }
      };

      request.fields['data'] = jsonEncode(payload);

      print("📦 Gym Payload: ${jsonEncode(payload)}");

      for (var i = 0; i < images.length; i++) {
        final file = await http.MultipartFile.fromPath(
          'images',
          images[i].path,
          filename: images[i].path.split('/').last,
        );
        request.files.add(file);
        print("📸 Attached image: ${file.filename}");
      }

      // ---- Send request --------------------------------------------------
      print("🚀 Sending POST to $uri");
      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      print("📡 Status Code: ${streamedResponse.statusCode}");
      print("📄 Response Body: $responseBody");

      // ---- Handle response ----------------------------------------------
      if (streamedResponse.statusCode == 200 ||
          streamedResponse.statusCode == 201) {
        final json = jsonDecode(responseBody);
        CustomToast.showToast("Gym added successfully!", isError: false);
        Get.offAll(() => DashboardView());
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
      print("❌ AddGymController error: $e");
      CustomToast.showToast(e.toString(), isError: true);
    } finally {
      isLoading(false);
    }
  }
}
