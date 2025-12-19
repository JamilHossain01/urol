import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import '../../firebase_options.dart';
import '../../view/user/home_view/controller/unread_notification_controller.dart';
import 'notification_controller.dart';

/// ---------------- BACKGROUND HANDLER ----------------
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  /// 1️⃣ Initialize Firebase (required in background)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print('📩 Background message received: ${message.notification?.title}');

  /// 2️⃣ Update unread notifications
  try {
    final UnreadNotificationController _unreadNotificationController =
    Get.put(UnreadNotificationController());
    await _unreadNotificationController.getUnReadController();
    print('✅ Unread notifications updated');
  } catch (e) {
    print('❌ Error updating unread notifications: $e');
  }

  /// 3️⃣ Show local notification (optional)
  try {
    await NotificationService.showNotification(
      title: message.notification?.title ?? message.data['title'],
      body: message.notification?.body ?? message.data['body'],
    );
    print('🔔 Background notification shown');
  } catch (e) {
    print('❌ Error showing background notification: $e');
  }
}
