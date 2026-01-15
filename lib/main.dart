// ignore_for_file: prefer_const_constructors

import 'package:calebshirthum/view/splash_view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'common controller/notification controller/firebase_background_handler.dart';
import 'common controller/notification controller/notification_controller.dart';
import 'common widget/language widget/controller/language_controller.dart';
import 'common widget/network_connectivity/controller/no_network_controller.dart';
import 'common widget/network_connectivity/no_network_view.dart';
import 'uitilies/api/local_storage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Storage
  await GetStorage.init();
  await Get.put(LanguageController()).initStorage();

  /// Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Notifications
  await NotificationService.requestPermission();
  await NotificationService.init();

  /// Background handler
  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );

  /// FCM token
  try {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      print("🔥 FCM Token: $token");
      await Get.put(StorageService()).write('fcmToken', token);
    }
  } catch (e) {
    print('❌ Token error: $e');
  }

  /// Portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

/// ================= APP =================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NetworkController(), permanent: true);

    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          fallbackLocale: Locale('en', 'US'),
          home: RootWithNetworkOverlay(),
        );
      },
    );
  }
}

/// ================= NETWORK WRAPPER =================
class RootWithNetworkOverlay extends StatelessWidget {
  const RootWithNetworkOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final networkController = Get.find<NetworkController>();

    return Obx(() {
      return Stack(
        children: [
          /// 🔹 Main App
          SplashView(),


          if (!networkController.isConnected.value)
            Positioned.fill(
              child: NoInternetView(),
            ),
        ],
      );
    });
  }
}

