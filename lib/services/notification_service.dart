import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/services/permission_service.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // Top-level function for background notification handling
  @pragma('vm:entry-point')
  static void _backgroundNotificationHandler(NotificationResponse response) {
    // Handle background notification tap
    debugPrint('Background Notification payload: ${response.payload}');
    // You can add more background handling logic here
  }

  Future<void> initialize() async {
    // Initialize timezone data
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
          macOS: null,
        );

    // For Android, register the background handler
    await _notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: _backgroundNotificationHandler,
    );
  }

  void _onNotificationTap(NotificationResponse response) {
    // Handle notification tap
    // You can navigate to a specific screen based on the payload
    if (response.payload != null) {
      debugPrint('Notification payload: ${response.payload}');
      // Example: Get.toNamed(response.payload!);
    }
  }

  Future<bool> checkAndRequestPermission() async {
    if (kIsWeb) return true;

    final permissionService = Get.find<PermissionService>();
    final hasPermission =
        await permissionService.isNotificationPermissionGranted();

    if (!hasPermission) {
      await permissionService.openAppSettingsIfNeeded();
      return false;
    }

    return true;
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    String? channelId = 'high_importance_channel',
    String? channelName = 'High Importance Notifications',
    String? channelDescription =
        'This channel is used for important notifications.',
    Importance importance = Importance.high,
    Priority priority = Priority.high,
  }) async {
    if (!await checkAndRequestPermission()) return;

    // Android-specific notification details
    final androidDetails = AndroidNotificationDetails(
      channelId!,
      channelName!,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
      showWhen: true,
      enableVibration: true,
      playSound: true,
      // Make sure to add 'ic_notification' to your Android project's drawable resources
      icon: 'ic_notification',
      // largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      ticker: 'ticker',
      styleInformation: const BigTextStyleInformation(''),
    );

    const iOSDetails = DarwinNotificationDetails();

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _notifications.show(id, title, body, details, payload: payload);
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'scheduled_notifications',
          'Scheduled Notifications',
          channelDescription:
              'Notifications that are scheduled to appear at a later time',
          importance: Importance.high,
          priority: Priority.high,
          fullScreenIntent: true,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }
}
