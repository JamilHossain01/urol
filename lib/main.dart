// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:calebshirthum/uitilies/api/local_storage.dart';
import 'package:calebshirthum/view/splash_view/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'common widget/language widget/controller/language_controller.dart';
import 'common widget/language widget/dep.dart' as dep;
import 'common widget/language widget/message.dart';
import 'firebase_options.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    print('Background message received: ${message.notification?.title}');
    _showNotification(message.notification?.title, message.notification?.body);
  } catch (e) {
    print('Error in background handler: $e');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage
  await GetStorage.init();

  // Initialize language controller
  await Get.put(LanguageController()).initStorage();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Request notification permissions
  await _requestNotificationPermissions();

  // Set up background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Get FCM token
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await fetchAPNSToken(messaging);
  try {
    String? token = await messaging.getToken();
    if (token != null) {
      print("FCM Token: $token");
      final StorageService storageService = Get.put(StorageService());
      await storageService.write('fcmToken', token);
      print("FCM Token saved to storage: $token");
    }
  } catch (e) {
    print("Error retrieving FCM token: $e");
  }

  // Configure local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      if (response.payload != null) {
        print('Notification payload: ${response.payload}');
      }
    },
  );

  // Handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Foreground message received: ${message.notification?.title}');
    _showNotification(
      message.notification?.title,
      message.notification?.body,
    );
  });

  runApp(MyApp());
}

// Fetch APNs Token (for iOS)
Future<void> fetchAPNSToken(FirebaseMessaging messaging) async {
  try {
    String? apnsToken = await messaging.getAPNSToken();
    if (apnsToken != null) {
      print("APNs Token: $apnsToken");
    } else {
      print("APNs Token not available.");
    }
  } catch (e) {
    print("Error fetching APNs token: $e");
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          fallbackLocale: Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          home: SplashView(),
          //  home: BottomNavigation(),
        );
      },
    );
  }
}

Future<void> _requestNotificationPermissions() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: true,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted notification permissions.');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional notification permissions.');
  } else {
    print('User declined or has not granted notification permissions.');
  }
}

Future<void> _showNotification(String? title, String? body) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'Your Channel Name',
    channelDescription: 'Your channel description',
    importance: Importance.max,
    priority: Priority.high,
  );

  const DarwinNotificationDetails darwinPlatformChannelSpecifics =
      DarwinNotificationDetails();

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: darwinPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    title ?? "No Title",
    body ?? "No Body",
    platformChannelSpecifics,
  );
}
