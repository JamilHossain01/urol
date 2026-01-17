// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../../../../uitilies/custom_toast.dart';
import '../model/all_map_gym_model.dart';

class AllMapGymController extends GetxController {
  var isLoading = false.obs;
  var profile = AllMapGymModel().obs;

  Future<void> getAllMapGym({
    required dynamic distance,
    required String searchTerm,
    required String disciplines,
  }) async {
    try {
      isLoading(true);
      print(
          '🔷 getAllMapGym() called -> distance:$distance, search:$searchTerm, disciplines:$disciplines');

      final response = await BaseClient.getRequest(
        api: ApiUrl.mapGym(
          searchTerm: searchTerm,
          distance: distance ?? 0,
          disciplines: disciplines,
        ),
      );

      final responseBody = await BaseClient.handleResponse(response);

      print('🔷 API raw response: $responseBody');

      if (responseBody['success'] == true) {
        profile.value = AllMapGymModel.fromJson(responseBody);
        final gymCount = profile.value.data?.length ?? 0;
        print("✅ fetched: $gymCount gyms");

        if (gymCount == 0) {
          CustomToast.showToast(
              "Unfortunately, no gyms were found with your current filter settings.",
              isError: true);
        }
      } else {
        print("⚠️ API returned success:false -> ${responseBody['message']}");
        throw 'Failed to load profile data: ${responseBody['message']}';
      }
    } catch (e, st) {
      print("❌ Error loading profile: $e");
      print(st);
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
