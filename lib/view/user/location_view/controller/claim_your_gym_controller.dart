import 'dart:convert';
import 'dart:io';
import 'package:calebshirthum/common%20widget/success_screen_widget.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as img;
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/local_storage.dart';
import '../../../../uitilies/custom_toast.dart';
import '../../dashboard_view/bottom_navigation_view.dart';

class ClaimYourGymController extends GetxController {
  var isLoading = false.obs;

  Future<File> compressImage(File file,
      {int width = 800, int quality = 80}) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) return file;

    final resized = img.copyResize(image, width: width);
    final compressedBytes = img.encodeJpg(resized, quality: quality);

    final compressedFile = File(file.path.replaceFirst('.', '_compressed.'));
    await compressedFile.writeAsBytes(compressedBytes);
    return compressedFile;
  }

  Future<void> claimYourGym({
    required File utilityBill,
    required File businessLicense,
    required File taxPhoto,
    required String email,
    required String gymId,
    required String phone,
  }) async {
    try {
      isLoading(true);

      final uri = Uri.parse(ApiUrl.claimGym);
      final storage = StorageService();
      final accessToken = storage.read<String>('accessToken');

      var request = http.MultipartRequest('POST', uri);

      if (accessToken != null && accessToken.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $accessToken';
      }

      // Main payload
      final Map<String, dynamic> payload = {
        "email": email,
        "phone": phone,
        "gym": "690ef46bf68c74f27ce553b4",
      };

      request.fields['data'] = jsonEncode(payload);
      print("📦 Gym Payload: ${jsonEncode(payload)}");

      // Compress images
      final compressedUtilityBill = await compressImage(utilityBill);
      final compressedBusinessLicense = await compressImage(businessLicense);
      final compressTaxPhoto = await compressImage(taxPhoto);

      // Print info to verify
      print(
          "🖼️ Utility Bill: ${compressedUtilityBill.path} | Size: ${await compressedUtilityBill.length()} bytes");
      print(
          "🖼️ Business License: ${compressedBusinessLicense.path} | Size: ${await compressedBusinessLicense.length()} bytes");
      print(
          "🖼️ Tax Photo: ${compressTaxPhoto.path} | Size: ${await compressTaxPhoto.length()} bytes");

      request.files.add(await http.MultipartFile.fromPath(
        'tax_document',
        compressTaxPhoto.path,
        contentType: MediaType('image', 'jpeg'),
        filename: compressTaxPhoto.path.split('/').last,
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'business_license',
        compressedBusinessLicense.path,
        contentType: MediaType('image', 'jpeg'),
        filename: compressedBusinessLicense.path.split('/').last,
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'utility_bill',
        compressedUtilityBill.path,
        contentType: MediaType('image', 'jpeg'),
        filename: compressedUtilityBill.path.split('/').last,
      ));

      print("🚀 Sending POST to $uri");
      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      print("📡 Status Code: ${streamedResponse.statusCode}");
      print("📄 Response Body: $responseBody");

      if (streamedResponse.statusCode == 200 ||
          streamedResponse.statusCode == 201) {
        Get.offAll(() => SuccessScreen(
              title: "Claim Submitted",
              message:
                  "Your gym claim submission has been successfully sent!\nOur administration team will review your submission soon and you will receive a notification if successfully verified.\nThank you!",
              buttonText: "Go to Dashboard",
              onPressed: () {
                Get.offAll(() => DashboardView());
              },
              buttonColor: AppColors.mainColor,
            ));
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
      print("❌ ClaimYourGymController error: $e");
      CustomToast.showToast(e.toString(), isError: true);
    } finally {
      isLoading(false);
    }
  }
}
