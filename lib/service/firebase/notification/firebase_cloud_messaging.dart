import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/common/data.dart';
import '../../../utils/common/key_data_local.dart';
import '../../../utils/stored/shared_preferences/set.dart';
import '../firebase_options.dart';

/// Hàm xử lý notification khi app đang ở background hoặc bị kill
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class FirebaseNotification {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final AndroidNotificationChannel _androidChannel =
  const AndroidNotificationChannel(
    'high_importance_channel', // ID channel
    'High Importance Notifications', // Tên channel hiển thị
    importance: Importance.max,
    enableLights: true,
    enableVibration: true,
    playSound: true,
    showBadge: true,
  );

  /// Khởi tạo cấu hình notification
  Future<void> initConfig() async {
    await _initFirebaseMessaging();
    await _initLocalNotification();
  }

  /// Cấu hình Firebase Messaging (push từ server)
  Future<void> _initFirebaseMessaging() async {
    try {
      // Bắt sự kiện thông báo khi app đang background/terminated
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        criticalAlert: true,
        announcement: true,
        carPlay: false,
        provisional: true,
      );

      if (Platform.isIOS) {
        await _firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
      }

      // Tắt chế độ tạo token mỗi lần mở app
      await _firebaseMessaging.setAutoInitEnabled(false);

      // Lấy FCM token
      final token = await _firebaseMessaging.getToken();
      if (kDebugMode) {
        print('[FCM Token] $token');
      }
      AppDataGlobal.fcmToken = token ?? '';
      await SetDataToLocal.setString(
        key: KeyDataLocal.fcmTokenKey,
        data: token ?? '',
      );
    } catch (e) {
      if (kDebugMode) {
        print('[FirebaseMessaging Error] $e');
      }
    }
  }

  /// Cấu hình hiển thị notification local
  Future<void> _initLocalNotification() async {
    try {
      const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

      final iosInit = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentSound: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          final launchUrlStr = json.decode(payload ?? '')['launchUrl'];
          if (launchUrlStr != null) {
            await launchUrl(
              Uri.parse(launchUrlStr),
              mode: LaunchMode.externalNonBrowserApplication,
            );
          }
        },
      );

      final initSettings = InitializationSettings(
        android: androidInit,
        iOS: iosInit,
      );

      await _localNotificationsPlugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onSelectNotification,
      );

      if (Platform.isAndroid) {
        await _localNotificationsPlugin
            .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(_androidChannel);
      } else if (Platform.isIOS) {
        await _localNotificationsPlugin
            .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
      }
    } catch (e) {
      debugPrint('[LocalNotification Error] $e');
    }
  }

  /// Xử lý khi bấm vào notification (app đang mở)
  Future<void> handleMessage() async {
    try {
      // Trường hợp app đang tắt → mở bằng notification
      final RemoteMessage? initialMessage =
      await _firebaseMessaging.getInitialMessage();

      if (initialMessage?.data.isNotEmpty ?? false) {
        _handleDataPayload(initialMessage!.data);
      }

      // Trường hợp app đang foreground → bấm noti
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        if (message.data.isNotEmpty) {
          _handleDataPayload(message.data);
        }
      });
    } catch (e) {
      debugPrint('[HandleMessage Error] $e');
    }
  }

  /// Hàm dùng để xử lý payload data khi nhấn vào notification
  void _handleDataPayload(Map<String, dynamic> data) {
    final type = data['type'];
    final membershipId = data['membershipId'];
    final session = data['session'];
    // TODO: xử lý điều hướng dựa vào type hoặc id
    print('[Notification Data] id: $membershipId, type: $type, session: $session');
  }

  /// Xử lý khi chọn vào notification local
  Future<void> _onSelectNotification(NotificationResponse? response) async {
    final payload = response?.payload;
    if (payload?.isNotEmpty ?? false) {
      final data = json.decode(payload!);
      final id = data['id'];
      final type = data['type'];
      print('[Tapped Local Notification] id: $id, type: $type');
      // TODO: chuyển hướng theo logic nếu cần
    }
  }

  /// Reset lại token FCM trên thiết bị
  Future<void> resetDeviceToken() async {
    await _firebaseMessaging.deleteToken();
  }

  /// Theo dõi token firebase thay đổi
  Future<void> handleTokenFirebase() async {
    final token = await _firebaseMessaging.getToken();
    if (kDebugMode) {
      print('[FCM Init Token] $token');
    }

    _firebaseMessaging.onTokenRefresh.listen((token) {
      if (kDebugMode) {
        print('[FCM Token Refresh] $token');
      }
    });
  }
}
