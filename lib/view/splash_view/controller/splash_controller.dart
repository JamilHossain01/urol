// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:calebshirthum/view/auth_view/login_auth_view.dart';
import 'package:get/get.dart';

import '../../../uitilies/api/local_storage.dart';
import '../../auth_view/log_in/view/log_in_view.dart';


class SplashController extends GetxController {
  Timer? timer;
  var opacity = 0.0.obs;
  final StorageService _storageService = Get.put(StorageService());

  @override
  void onInit() {
    super.onInit();

    timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
      if (opacity.value != 1.0) {
        opacity.value += 0.5;
      }
    });

    Future.delayed(const Duration(seconds: 3), () async {
      Get.to(() => LogInView());
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
