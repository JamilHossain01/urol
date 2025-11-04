// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:calebshirthum/view/auth_view/login_auth_view.dart';
import 'package:get/get.dart';
import '../../../uitilies/api/local_storage.dart';
import '../../auth_view/log_in/view/log_in_view.dart';
import '../../user/dashboard_view/bottom_navigation_view.dart';

class SplashController extends GetxController {
  Timer? timer;
  var opacity = 0.0.obs;
  final StorageService _storageService = Get.put(StorageService());

  @override
  void onInit() {
    super.onInit();

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (opacity.value < 1.0) {
        opacity.value += 0.5;
      } else {
        timer?.cancel();
      }
    });

    Future.delayed(const Duration(seconds: 3), () async {
      String? accessToken = await _storageService.read('accessToken');

      if (accessToken != null && accessToken.isNotEmpty) {
        Get.offAll(() => DashboardView());
      } else {
        Get.offAll(() => SignInView());
      }
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
