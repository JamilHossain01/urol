// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/local_storage.dart';
import '../../../../uitilies/custom_toast.dart';
import '../../dashboard_view/bottom_navigation_view.dart';
import '../../home_view/controller/my_profile_controller.dart';

class UpdateProfileController extends GetxController {
  var isLoading = false.obs;

  final GetProfileController _getProfileController =
      Get.put(GetProfileController());

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? contact,
    String? beltRank,
    List<String>? disciplines,
    String? favouriteQuote,
    double? heightCm,
    String? weight,
    String? homeGym,
    File? profilePicture,
  }) async {
    try {
      isLoading(true);

      final uri = Uri.parse(ApiUrl.updateProfile);
      final storage = StorageService();
      final accessToken = storage.read<String>('accessToken');

      var request = http.MultipartRequest('PATCH', uri);

      // ---- Headers -------------------------------------------------------
      if (accessToken != null && accessToken.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $accessToken';
      }

      // ---- Build the JSON payload exactly as the API expects ------------
      final Map<String, dynamic> payload = {
        "first_name": firstName,
        "last_name": lastName,
        "contact": contact,
        "belt_rank": beltRank,
        "disciplines": disciplines,
        "favourite_quote": favouriteQuote,
        "height": {"amount": heightCm!.round(), "category": "cm"},
        "weight": weight,
        "home_gym": homeGym,
      };

      request.fields['data'] = jsonEncode(payload);

      print("Profile Update Payload:");
      print(jsonEncode(payload));

      // ---- Attach image (if any) ----------------------------------------
      if (profilePicture != null) {
        final file = await http.MultipartFile.fromPath(
          'image', // field name expected by backend
          profilePicture.path,
          filename: profilePicture.path.split('/').last,
        );
        request.files.add(file);
        print("Attached image: ${file.filename}");
      } else {
        print("No image attached");
      }

      // ---- Send request --------------------------------------------------
      print("Sending PATCH to ${uri}...");
      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      print("Response ${streamedResponse.statusCode}");
      print(responseBody);

      // ---- Handle response ------------------------------------------------
      if (streamedResponse.statusCode == 200) {
        final json = jsonDecode(responseBody);

        if (json['success'] == true) {
          CustomToast.showToast("Profile updated successfully!");
          Get.offAll(() => DashboardView());
          _getProfileController.getProfileController();
        } else {
          final msg = json['message'] ?? 'Update failed.';
          CustomToast.showToast(msg, isError: true);
        }
      } else {
        throw 'Server error: ${streamedResponse.statusCode}';
      }
    } catch (e) {
      print('UpdateProfileController error: $e');
      CustomToast.showToast(e.toString(), isError: true);
    } finally {
      isLoading(false);
    }
  }
}
