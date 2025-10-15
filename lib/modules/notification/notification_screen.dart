import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/models/notification/notification_model.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'notification_controller.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends GetView<NotificationController> {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Updates", style: TextStyles.headline6),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: const [
                Text(
                  "Notifications ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.notifications, color: Colors.green),
              ],
            ),
          ),
          const Gap(12),
          // Tabs
          Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children:
                    controller.tabs.map((tab) {
                      bool selected = controller.selectedTab.value == tab;
                      return GestureDetector(
                        onTap: () => controller.changeTab(tab),
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: selected ? Colors.green : ColorConst.grey300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tab,
                            style: TextStyle(
                              color:
                                  selected
                                      ? ColorConst.white
                                      : ColorConst.grey400,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
          const Gap(12),

          // Notifications List
          Obx(() {
            if (controller.isLoading.value) {
              return const Expanded(
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final notifications = controller.filteredNotifications;

            if (notifications.isEmpty) {
              return const Expanded(
                child: Center(child: Text('No notifications found')),
              );
            }

            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return _buildNotificationCard(notification);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

Widget _buildNotificationCard(NotificationModel notification) {
  final type = notification.type?.toLowerCase() ?? '';
  final orderId =
      notification.id?.substring(0, 8) ??
      'N/A'; // Using first 8 chars of ID as order ID
  final message = notification.message ?? 'No message';
  final time =
      notification.createdAt != null
          ? _formatTimeAgo(notification.createdAt!)
          : 'Just now';

  if (type.contains('delivered')) {
    return NotificationCard.delivered(
      orderId: orderId,
      message: message,
      time: time,
    );
  } else if (type.contains('payment') || type.contains('penalty')) {
    return NotificationCard.penalty(
      orderId: orderId,
      message: message,
      time: time,
    );
  } else {
    return NotificationCard.newOrder(
      title: notification.title ?? "New Order $orderId",
      orderId: orderId,
      address: notification.message ?? 'No address',
      // Using subMessage as address
      time: time,
      duration: 'N/A', // Add duration to NotificationModel if needed
    );
  }
}

String _formatTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 30) {
    return DateFormat('MMM d, y').format(dateTime);
  } else if (difference.inDays > 0) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
  } else {
    return 'Just now';
  }
}

// ------------------ NOTIFICATION CARD ------------------ //

class NotificationCard extends StatelessWidget {
  final Widget leadingIcon;
  final String title;
  final String subtitle;
  final String time;
  final Color? statusColor;
  final String? statusText;

  const NotificationCard({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.time,
    this.statusColor,
    this.statusText,
  });

  // Factory for new order
  factory NotificationCard.newOrder({
    required String title,
    required String orderId,
    required String address,
    required String duration,
    required String time,
  }) {
    return NotificationCard(
      leadingIcon: const Icon(Icons.shopping_bag, color: Colors.blue, size: 28),
      title: title,
      subtitle: "Pickup Location\n$address\n⏱ $duration",
      time: time,
      statusColor: Colors.blue,
      statusText: "New",
    );
  }

  // Factory for delivered
  factory NotificationCard.delivered({
    required String orderId,
    required String message,
    required String time,
  }) {
    return NotificationCard(
      leadingIcon: const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 28,
      ),
      title: "Order $orderId delivered",
      subtitle: message,
      time: time,
      statusColor: Colors.green,
      statusText: "Completed",
    );
  }

  // Factory for penalty
  factory NotificationCard.penalty({
    required String orderId,
    required String message,
    required String time,
  }) {
    return NotificationCard(
      leadingIcon: const Icon(Icons.warning, color: Colors.red, size: 28),
      title: "Order $orderId\nLate delivery penalty",
      subtitle: message,
      time: time,
      statusColor: Colors.red,
      statusText: "Deduction",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          leadingIcon,
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    if (statusText != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor!.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          statusText!,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const Gap(4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                ),
                const Gap(4),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
