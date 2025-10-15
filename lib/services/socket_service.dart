import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:orsolum_delivery/api/api_const.dart';
import 'package:orsolum_delivery/models/delivery_task.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:orsolum_delivery/utils/storage_utils.dart';
import 'package:orsolum_delivery/services/notification_service.dart';

class SocketService extends GetxService {
  static SocketService get to => Get.find();

  // Event Bus for cross-controller communication
  final _eventController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get events => _eventController.stream;

  // Socket instance
  IO.Socket? _socket;
  final _storage = StorageUtils.instance;
  final _isConnected = false.obs;
  // Expose a typed reactive connection state for observers
  RxBool get rxIsConnected => _isConnected;
  static const int _reconnectInterval = 5; // seconds
  Timer? _reconnectTimer;
  int _reconnectAttempt = 0;
  bool _isManuallyDisconnected = false;
  bool _isInitialized = false;
  final RxList<DeliveryTask> deliveryTasks = <DeliveryTask>[].obs;

  bool get isConnected => _isConnected.value;

  bool get isInitialized => _isInitialized;

  // Public getter for the socket instance
  IO.Socket? get socket => _socket;

  // Singleton instance
  static Future<SocketService> init() async {
    if (!Get.isRegistered<SocketService>()) {
      final instance = SocketService();
      await Get.putAsync<SocketService>(() async {
        instance._initializeSocket();
        return instance;
      });
      return instance;
    }
    return Get.find<SocketService>();
  }

  @override
  void onInit() async {
    super.onInit();
    // Initialize socket only if not already initialized
    if (_socket == null) {
      _initializeSocket();
    }
    // Initialize notification service
    await _notificationService.initialize();
  }

  void _initializeSocket() {
    if (_isInitialized) return;
    _isInitialized = true;
    initSocket();
  }

  Future<void> initSocket() async {
    print('🚀 [SOCKET] Initializing socket connection...');

    try {
      const socketUrl = ApiConst.socketUrl;
      if (socketUrl.isEmpty || socketUrl == 'YOUR_SOCKET_IO_SERVER_URL') {
        throw Exception('Invalid socket URL configuration');
      }

      // DNS pre-check to avoid repeated failing attempts on unreachable hosts
      final canResolve = await _canResolveHost(socketUrl);
      if (!canResolve) {
        print("❌ [SOCKET] DNS lookup failed for host: ${Uri.parse(socketUrl).host}");
        _isConnected.value = false;
        _scheduleReconnect();
        return;
      }

      final user = await _storage.getUser();
      if (user == null || user.id.isEmpty) {
        //  throw Exception('User session not found or invalid');
        print('❌ [SOCKET] User session not found or invalid');
        _isConnected.value = false;
        _scheduleReconnect();
        return;
      }

      final userId = user.id;
      final token = user.token;

      _reconnectTimer?.cancel();
      _reconnectTimer = null;

      // Clean up existing socket
      _socket?.disconnect();
      _socket?.dispose();
      _socket = null;

      // Derive base URL and Socket.IO engine path
      final parsed = Uri.parse(socketUrl);
      final baseUrl = '${parsed.scheme}://${parsed.host}'; // implicit 443 for https
      final namespace = parsed.path; // e.g. /delivery
      final enginePath = '/socket.io/'; // default engine path

      final options = IO.OptionBuilder()
        
        // .setTransports(['websocket'])  
          // Allow polling fallback; some proxies block direct websocket upgrade
          .setTransports(['websocket', 'polling'])
          .setPath(enginePath) // use default engine path
          .enableReconnection()
          .setReconnectionDelay(1000)
          .setReconnectionDelayMax(5000)
          .setReconnectionAttempts(5)
          .setTimeout(20000)
          .enableForceNew()
         
               // Derive proper base URL and Socket.IO path
      // Build a clean base URL without port to avoid :0 issues
     
      // final baseUrl = '${parsed.scheme}://${parsed.host}${parsed.hasPort ? ':${parsed.port}' : ''}';
      // final path = (parsed.path.isEmpty ? '' : parsed.path) + '/socket.io/';
     
      // final baseUrl = '${parsed.scheme}://${parsed.host}';
      // final path = parsed.path.endsWith('/')
      //     ? '${parsed.path}socket.io/'
      //     : '${parsed.path}/socket.io/';
        
         
          // Prefer query for widest server compatibility
          .setQuery({'token': token, 'deliveryBoyId': userId})
          .setExtraHeaders({
            'X-Platform': GetPlatform.isAndroid
                ? 'android'
                : GetPlatform.isIOS
                    ? 'ios'
                    : GetPlatform.isWeb
                        ? 'web'
                        : 'unknown',
          })
          .build();

      // Connect to proper namespace (e.g., https://api.orsolum.com/delivery)
      _socket = IO.io(baseUrl + namespace, options);
      print('✅ [SOCKET] Socket instance created');

      _setupSocketListeners();

      print('🔌 [SOCKET] Connecting...');
      // setOnlineStatus(true);
      _socket?.connect();
    } catch (e, stackTrace) {
      print('❌ [SOCKET] Initialization error: $e');
      print(stackTrace);
      _scheduleReconnect();
    }
  }

  Future<bool> _canResolveHost(String url) async {
    try {
      final uri = Uri.parse(url);
      if (uri.host.isEmpty) return false;
      final result = await InternetAddress.lookup(uri.host).timeout(const Duration(seconds: 3));
      return result.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  // Emit event to all listeners
  void _emitEvent(String type, dynamic data) {
    _eventController.add({
      'type': type,
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // Method to request delivery tasks
  void requestDeliveryTasks() {
    if (_socket?.connected == true) {
      _socket?.emit('getDeliveryTask');
      print('🔄 [SOCKET] Requested delivery tasks');
    }
  }

  // Current active delivery task
  final Rx<Map<String, dynamic>?> currentDeliveryTask = Rx<Map<String, dynamic>?>(null);

  // (Removed unused _handleDeliveryTaskUpdate)



 // Method to handle delivery task updates
  // void _handleDeliveryTaskUpdate(dynamic data) {
  //   try {
  //     if (data is Map<String, dynamic>) {
  //       currentDeliveryTask.value = data;
  //       print('📦 [SOCKET] Updated current delivery task');
  //     } else if (data is List && data.isNotEmpty) {
  //       // If we get a list, take the first task
  //       currentDeliveryTask.value = data.first;
  //       print('📦 [SOCKET] Updated current delivery task from list');
  //     }
  //   } catch (e) {
  //     print('❌ [SOCKET] Error handling delivery task: $e');
  //   }
  // }

  bool _hasRequestedNotification = false;

  void requestOldNotification() {
    print('🔍 [SOCKET] Requesting old notifications...');
    print('🔌 [SOCKET] Socket connected: ${_socket?.connected}');
    print('📝 [SOCKET] Has requested notification: $_hasRequestedNotification');

    if (_socket?.connected == true) {
      if (!_hasRequestedNotification) {
        print('📤 [SOCKET] Emitting getNotifications with ack');

        // Emit with acknowledgment callback
        _socket?.emitWithAck(
          'getNotifications',
          {},
          ack: (dynamic response) {
            if (response is Map && response['success'] == true) {
              print(
                '✅ [SOCKET] Received ${response['data']?.length ?? 0} notifications',
              );
              _emitEvent('notificationList', response['data']);
            } else {
              print(
                '❌ [SOCKET] Failed to get notifications: ${response?['message'] ?? 'Unknown error'}',
              );
            }
            _hasRequestedNotification = false; // Reset to allow future requests
          },
        );

        _hasRequestedNotification = true;
      } else {
        print('ℹ️ [SOCKET] Notifications already requested');
      }
    } else {
      print('❌ [SOCKET] Cannot request notifications: Socket not connected');
    }
  }

  final NotificationService _notificationService = NotificationService();
  int _notificationId = 0;

  void _setupSocketListeners() {
    print('🔌 [SOCKET] Setting up socket listeners...');

    _socket?.onConnect((_) {
      _emitEvent('connected', null);
      _isConnected.value = true;
      _isManuallyDisconnected = false;
      _reconnectAttempt = 0; // reset exponential backoff on success
      _hasRequestedNotification = false; // Reset notification flag too
      print('✅ [SOCKET] Connected to server: ${_socket?.id}');
      print('🔄 [SOCKET] Connection status: ${_socket?.connected}');

      // Set online status and request delivery tasks
      setOnlineStatus(true).then((_) {
        // Request delivery tasks after going online
        requestDeliveryTasks();
      });
    });

    // Listen for delivery tasks response
    _socket?.on('getDeliveryTask', (data) {
      print('📦 [SOCKET] Delivery task data received');
      _emitEvent('delivery_task', data);
      _handleDeliveryTask(data);
      // Delivery request completed
    });

    // Listen for notification responses

    // Listen for real-time notifications
    _socket?.on('newNotification', (data) async {
      try {
        print('🔔 [SOCKET] New notification received');
        if (data != null) {
          print('📝 [SOCKET] Notification data: $data');
          _emitEvent('newNotification', data);

          // Extract notification details from data
          final title = data['title'] ?? 'New Notification';
          final body = data['message'] ?? 'You have a new notification';
          final payload = data['payload']?.toString();

          // Show local notification
          await _notificationService.showNotification(
            id: _notificationId++,
            title: title,
            body: body,
            payload: payload,
          );

          print('✅ [NOTIFICATION] Push notification shown: $title - $body');
        } else {
          print('⚠️ [SOCKET] Received empty notification data');
        }
      } catch (e, stackTrace) {
        print('❌ [SOCKET] Error handling new notification: $e');
        print('Stack trace: $stackTrace');
      }
    });

    // Log when the listener is set up
    print('👂 [SOCKET] Listening for new notifications');

    _socket?.onConnectError((error) {
      _isConnected.value = false;
      print('❌ [SOCKET] Connection error: $error');
    });

    _socket?.onError((error) {
      print('⚠️ [SOCKET] General error: $error');
    });

    _socket?.onDisconnect((_) {
      _isConnected.value = false;
      print('⚠️ [SOCKET] Disconnected');
      if (!_isManuallyDisconnected) {
        _scheduleReconnect();
      }
    });

    _socket?.onReconnect((_) {
      _isConnected.value = true;
      print('✅ [SOCKET] Reconnected');
    });

    _socket?.onReconnectAttempt((attempt) {
      print('🔄 [SOCKET] Reconnection attempt: $attempt');
    });

    _socket?.onReconnectError((error) {
      print('❌ [SOCKET] Reconnection error: $error');
    });

    _socket?.onReconnectFailed((data) {
      print('❌ [SOCKET] Reconnection failed: $data');
    });
  }

  void _scheduleReconnect() {
    if (_isManuallyDisconnected || _reconnectTimer != null) return;

    // Exponential backoff with a cap
    _reconnectAttempt++;
    final backoffSeconds = _computeBackoffSeconds(_reconnectAttempt);
    print('⏱ Scheduling reconnect in ' + backoffSeconds.toString() + ' seconds...');
    _reconnectTimer = Timer(Duration(seconds: backoffSeconds), () {
      print('🔄 Attempting to reconnect...');
      initSocket();
    });
  }

  int _computeBackoffSeconds(int attempt) {
    // 5, 10, 20, 40, 60, 60, ...
    final base = _reconnectInterval * (1 << (attempt - 1));
    final capped = base > 60 ? 60 : base;
    return capped;
  }

  Future<void> setOnlineStatus(bool isOnline) async {
    if (!_isConnected.value || _socket == null) return;

    try {
      final user = await _storage.getUser();
      if (user == null || user.id.isEmpty) {
        throw Exception('Invalid user session');
      }

      final event = 'goOnline';
      _socket!.emit(event, {"deliveryBoyId": user.id});
      print('📡 Emitted $event event');
    } catch (e) {
      print('❌ [SOCKET] Error setting online status: $e');
    }
  }

  Future<void> updateLocation(double lat, double lng) async {
    if (!isConnected || _socket == null) {
      print('⚠️ Cannot update location: Not connected');
      return;
    }

    try {
      final user = await _storage.getUser();
      if (user == null || user.id.isEmpty) {
        throw Exception('User not found');
      }

      _socket!.emit('update_location', {
        'userId': user.id,
        'location': {'lat': lat, 'lng': lng},
      });
      print('📡 Location updated');
    } catch (e) {
      print('❌ [SOCKET] Error updating location: $e');
    }
  }

  void _handleDeliveryTask(dynamic data) {
    try {
      final task = DeliveryTask.fromJson(Map<String, dynamic>.from(data));
      deliveryTasks.add(task);
      print('✅ Task stored: ${task.taskId}');
    } catch (e) {
      print('❌ Failed to parse delivery task: $e');
    }
  }

  Future<void> disconnect() async {
    print('🛑 Manually disconnecting socket...');
    _isManuallyDisconnected = true;
    _socket?.disconnect();
  }

  Future<void> reconnect() async {
    if (isConnected) return;
    _isManuallyDisconnected = false;
    await initSocket();
  }

  @override
  void onClose() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;

    _socket?.disconnect();
    _socket?.clearListeners();
    _socket = null;

    super.onClose();
  }
}
