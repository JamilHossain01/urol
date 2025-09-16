import 'package:get/get.dart';

class SettingController extends GetxController {
  final RxBool notificationValue = false.obs;


  void toggleNotification(bool value) {
    notificationValue.value = value;
  }
}