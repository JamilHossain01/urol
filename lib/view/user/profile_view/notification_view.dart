import 'package:calebshirthum/view/user/profile_view/controller/get_all_notification_controller.dart';
import 'package:calebshirthum/view/user/profile_view/model/notification_model.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/notification_item_widget.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/notification_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/not_found_widget.dart';
import '../../../uitilies/custom_loader.dart';
import 'controller/notification_single_read_controller.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final GetAllNotificationController _controller =
      Get.put(GetAllNotificationController());

  final GetReadAllNotificationController _readController =
      Get.put(GetReadAllNotificationController());

  List<NotificationData> todayNotifications = [];
  List<NotificationData> previousNotifications = [];

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    await _controller.getNotification();

    final notifications = _controller.notification.value.data?.data ?? [];
    final now = DateTime.now();

    todayNotifications = notifications.where((n) {
      final createdAt = n.createdAt;
      if (createdAt == null) return false;
      return createdAt.year == now.year &&
          createdAt.month == now.month &&
          createdAt.day == now.day;
    }).toList();

    previousNotifications = notifications.where((n) {
      final createdAt = n.createdAt;
      if (createdAt == null) return false;
      return !(createdAt.year == now.year &&
          createdAt.month == now.month &&
          createdAt.day == now.day);
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Notifications',
        showLeadingIcon: true,
      ),
      body: Obx(() {
        if (_controller.isLoading.value || _readController.isLoading.value) {
          return Center(child: CustomLoader());
        }

        final notificationData =
            _controller.notification.value.data?.data ?? [];

        if (notificationData.isEmpty) {
          return const Center(
            child: NotFoundWidget(
              imagePath: "assets/images/not_found.png",
              message: "No notifications found!",
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: _fetchNotifications,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            children: [
              if (todayNotifications.isNotEmpty)
                NotificationSection(
                  title: 'Today',
                  notifications: todayNotifications
                      .map((n) => NotificationItem(
                            isRead: n.isRead ?? false,
                            title: n.title ?? '',
                            subtitle: " ${n.message ?? ''}",
                            time: _formatTime(n.createdAt),
                            onTapForSingleTap: () async {
                              _readController.getRead(
                                  notificationId: n.id.toString());
                            },
                          ))
                      .toList(),
                ),
              if (previousNotifications.isNotEmpty) ...[
                SizedBox(height: 24.h),
                NotificationSection(
                  title: 'Previous Day',
                  notifications: previousNotifications
                      .map((n) => NotificationItem(
                            isRead: n.isRead ?? false,
                            title: n.title ?? '',
                            subtitle: " ${n.message ?? ''}",
                            time: _formatTime(n.createdAt),
                            onTapForSingleTap: () async {
                              _readController.getRead(
                                  notificationId: n.id.toString());
                            },
                          ))
                      .toList(),
                ),
              ],
            ],
          ),
        );
      }),
    );
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final amPm = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $amPm';
  }
}
