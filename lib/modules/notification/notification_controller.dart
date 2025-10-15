import 'dart:async';

import 'package:get/get.dart';
import 'package:orsolum_delivery/services/socket_service.dart';
import 'package:orsolum_delivery/models/notification/notification_model.dart';

class NotificationController extends GetxController {
  static NotificationController get to => Get.find();

  final RxString selectedTab = "All".obs;
  final List<String> tabs = ["All", "New Orders", "Delivered", "Payments"];
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxBool isLoading = true.obs;

  late final SocketService _socketService;
  StreamSubscription? _notificationSubscription;

  @override
  void onInit() {
    super.onInit();
    try {
      _socketService = Get.find<SocketService>();
      _setupSocketListeners();
      
      // Only request notifications if already connected
      if (_socketService.isConnected) {
        _requestNotifications();
      } else {
        // Listen for connection changes
        ever<bool>(_socketService.rxIsConnected, (isConnected) {
          if (isConnected) {
            _requestNotifications();
          }
        });
      }
      
      print('✅ [NOTIFICATION] Controller initialized with SocketService');
    } catch (e) {
      print('❌ [NOTIFICATION] Error initializing controller: $e');
    }
  }

  @override
  void onClose() {
    _notificationSubscription?.cancel();
    super.onClose();
  }

  void _setupSocketListeners() {
    // Listen for new notifications
    _notificationSubscription = _socketService.events.listen((event) {
      print('📡 [NOTIFICATION] Received event: ${event['type']}');
      
      if (event['type'] == 'newNotification') {
        _handleNewNotification(event['data']);
      } else if (event['type'] == 'notificationList') {
        _handleNotificationList(event['data']);
      } else if (event['type'] == 'connected') {
        // Handle connection established
        _requestNotifications();
      }
    });
  }

  void _requestNotifications() {
    print('🔄 [NOTIFICATION] Requesting notifications...');
    isLoading.value = true;
    try {
      _socketService.requestOldNotification();
      print('✅ [NOTIFICATION] Notification request sent');
    } catch (e) {
      print('❌ [NOTIFICATION] Error requesting notifications: $e');
      isLoading.value = false;
    }
  }

  void _handleNewNotification(Map<String, dynamic> notification) {
    try {
      // Convert the notification map to NotificationModel
      final notificationModel = NotificationModel.fromJson(notification);
      // Add new notification to the beginning of the list
      notifications.insert(0, notificationModel);
      print('📩 [NOTIFICATION] New notification added: ${notificationModel.title}');
    } catch (e) {
      print('❌ [NOTIFICATION] Error parsing new notification: $e');
    }
  }

  void _handleNotificationList(List<dynamic> notificationList) {
    try {
      final List<NotificationModel> parsedNotifications = [];
      
      for (var item in notificationList) {
        try {
          if (item is Map<String, dynamic>) {
            parsedNotifications.add(NotificationModel.fromJson(item));
          }
        } catch (e) {
          print('⚠️ [NOTIFICATION] Error parsing notification item: $e');
        }
      }
      
      notifications.value = parsedNotifications;
      print('✅ [NOTIFICATION] Loaded ${notifications.length} notifications');
    } catch (e) {
      print('❌ [NOTIFICATION] Error parsing notification list: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
  }

  // Filter notifications based on selected tab
  List<NotificationModel> get filteredNotifications {
    if (selectedTab.value == "All") return notifications;

    return notifications.where((notification) {
      final type = notification.type?.toLowerCase() ?? '';
      if (selectedTab.value == "New Orders") {
        return type.contains('order') && !type.contains('delivered');
      } else if (selectedTab.value == "Delivered") {
        return type.contains('delivered');
      } else if (selectedTab.value == "Payments") {
        return type.contains('payment') || type.contains('penalty');
      }
      return false;
    }).toList();
  }
}
