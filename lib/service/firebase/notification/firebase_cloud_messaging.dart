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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class FirebaseNotification {
  Future<void> initConfig() async {
    await _initFirebaseMessaging();
    await _initLocalNotification();
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final AndroidNotificationChannel _androidNotificationChannel =
  const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
    enableLights: true,
    enableVibration: true,
    playSound: true,
    showBadge: true,
  );

  Future<void> _initFirebaseMessaging() async {
    try {
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );

      ///Nhận thông báo khi đang mở ứng dụng trên IOS
      if (Platform.isIOS) {
        await _firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
      }

      // //Kiểm tra FCM token đã có trong đt chưa
      // String fcm =
      //     await GetDataFromLocal.getString(key: KeyDataLocal.fcmTokenKey);
      //
      // // Nếu Token đã được tạo thì không cần tạo lại
      // if(fcm != '') {
      //   print('***** FCM token is exist !!!');
      //   return;
      // };

      /// Dùng để tự động tạo FCM token
      /// True: mỗi lần mở app sẽ gọi và tạo FCM token mới
      /// False: chỉ tạo 1 lần đầu - Nên để false
      await _firebaseMessaging.setAutoInitEnabled(false);

      /// Lấy FCM token
      /// FCM là unique token trên mỗi thiết bị dùng để push noti
      await _firebaseMessaging.getToken().then((String? token) async {
        if (kDebugMode) {
          print('***** FCM Token: $token');
        }

        await SetDataToLocal.setString(
            key: KeyDataLocal.fcmTokenKey, data: token.toString());

        AppDataGlobal.fcmToken = token ?? '';
      });
    } catch (e) {
      if (kDebugMode) {
        print('***** Bug from initFirebaseMessaging: $e');
      }
    }
  }

  Future<void> _initLocalNotification() async {
    try {
      const AndroidInitializationSettings initialzationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
      final DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentSound: true,
        onDidReceiveLocalNotification:
            (int? id, String? title, String? body, String? payload) async {
          await launchUrl(
              Uri.parse(json.decode(payload!)['launchUrl'].toString()),
              mode: LaunchMode.externalNonBrowserApplication);
          // if (payload?.isNotEmpty ?? false) {
          /// ["id"]: Key json chứa ID của thông báo server trả về.
          /// Dùng để điều hướng vào màn chi tiết thông báo
          /// Mặc định đang là ["id"]
          // Navigator.of(AppConfig.navigatorKey.currentContext).pushNamed(
          //   DetailNotificationScreen.routeName,
          //   arguments: int.tryParse(
          //     json.decode(payload)["id"]?.toString(),
          //   ),
          // );
          // }
        },
      );
      final InitializationSettings initializationSettings =
      InitializationSettings(
        android: initialzationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      try {
        await _flutterLocalNotificationsPlugin.initialize(
          initializationSettings,
          onDidReceiveNotificationResponse: _onSelectNotifcation,

          /// ******************* onDidReceiveBackgroundNotificationResponse *******************
          // onDidReceiveBackgroundNotificationResponse: _onSelectNotifcation,
        );
      } catch (e) {
        if (kDebugMode) {
          print('initialize: ${e.toString()}');
        }
      }

      if (Platform.isIOS) {
        await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
      } else if (Platform.isAndroid) {
        await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(_androidNotificationChannel);
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> handleMessage() async {
    try {
      /// Lấy tất cả thông báo khiến ứng dụng mở từ terminated state
      /// Một khi lấy ra thông báo để điều hướng, nó sẽ bị remove
      /// Tương tác với thông báo khi ứng dụng đang ở terminated
      final RemoteMessage? initialMessage =
      await _firebaseMessaging.getInitialMessage();

      /// Khi khởi động app thì sẽ chạy vào đây
      /// Nếu App đang tắt và nhấn mở thông báo thì initialMessage sẽ có data
      /// Xử lý tương tác với thông báo khi người dùng đang tắt app
      if (initialMessage != null) {
        if (initialMessage.data.isNotEmpty) {
          /// ["id"]: Key json chứa ID của thông báo server trả về.
          /// Dùng để điều hướng vào màn chi tiết thông báo
          /// Mặc định đang là ["id"]
          // Navigator.of(AppConfig.navigatorKey.currentContext).pushNamed(
          //   DetailNotificationScreen.routeName,
          //   arguments: int.tryParse(
          //     initialMessage?.data["id"]?.toString(),
          //   ),
          // );
        }
      }

      /// Khi đang mở ứng dụng, thông báo Firebase sẽ vào hàm onMessageOpenedApp
      /// Android sẽ block toàn bộ thông báo đẩy, cần cấu hình thêm thư viện flutter_local_notifications để hiển thị thông báo cũng như tương tác thông báo
      /// IOS cần call hàm setForegroundNotificationPresentationOptions để nhận thông báo khi đang mở ứng dụng
      /// Cơ chế hiện tại đang có thể nhận thông báo khi đang dùng ứng dụng nhưng nếu muốn custom lại thì dùng hàm này
      FirebaseMessaging.onMessageOpenedApp.listen(
            (RemoteMessage message) {
          /// ["id"]: Key json chứa ID của thông báo server trả về.
          /// Dùng để điều hướng vào màn chi tiết thông báo
          /// Mặc định đang là ["id"]
          if (message.data.isNotEmpty) {
            // Navigator.of(AppConfig.navigatorKey.currentContext).pushNamed(
            //   DetailNotificationScreen.routeName,
            //   arguments: int.tryParse(
            //     message?.data["id"]?.toString(),
            //   ),
            // );
          }
        },
      );
    } catch (e) {
      debugPrint('$e');
    }
  }

  // Future<void> _showNotification(RemoteMessage message) async {
  //   print('================== Message ==================');
  //   try {
  //     final RemoteNotification? remoteNotification = message.notification;
  //
  //     final bigPicturePath = await Utils.downloadFile(
  //         remoteNotification?.android?.imageUrl.toString() ?? '', 'bigPicture');
  //
  //     print('remoteNotification:${remoteNotification?.title}');
  //     if (remoteNotification != null) {
  //       print('go go');
  //       await _flutterLocalNotificationsPlugin.show(
  //         remoteNotification.hashCode,
  //         remoteNotification.title,
  //         remoteNotification.body,
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             _androidNotificationChannel.id,
  //             _androidNotificationChannel.name,
  //             importance: Importance.max,
  //             visibility: NotificationVisibility.public,
  //             priority: Priority.max,
  //             playSound: true,
  //             enableLights: true,
  //             enableVibration: true,
  //             styleInformation: bigPicturePath == ''
  //                 ? null
  //                 : BigPictureStyleInformation(
  //                     FilePathAndroidBitmap(bigPicturePath),
  //                   ),
  //           ),
  //           iOS: DarwinNotificationDetails(
  //             presentAlert: true,
  //             presentBadge: true,
  //             presentSound: true,
  //             subtitle: remoteNotification.title,
  //           ),
  //         ),
  //         payload: json.encode(message.data),
  //       );
  //     }
  //   } catch (e) {
  //     debugPrint('Error message: $e');
  //   }
  // }

  Future<void> _onSelectNotifcation(
      NotificationResponse? notificationResponse) async {
    print(
        'ONTAP NOTIFICATION: ${notificationResponse?.payload} -- ${notificationResponse?.id}');

    // if (payload?.isNotEmpty ?? false) {
    /// ["id"]: Key json chứa ID của thông báo server trả về.
    /// Dùng để điều hướng vào màn chi tiết thông báo
    /// Mặc định đang là ["id"]
    // Navigator.of(AppConfig.navigatorKey.currentContext).pushNamed(
    //   DetailNotificationScreen.routeName,
    //   arguments: int.tryParse(
    //     json.decode(payload)["id"]?.toString(),
    //   ),
    // );
    // }
  }

  Future<void> resetDeviceToken() async {
    await _firebaseMessaging.deleteToken();
  }

  Future<void> handleTokenFirebase() async {
    await _firebaseMessaging.getToken().then((String? token) {
      if (kDebugMode) {
        print('FIREBASE TOKEN: $token');
      }
    });
    _firebaseMessaging.onTokenRefresh.listen((token) {
      if (kDebugMode) {
        print('TOKEN FIREBASE CHANGE: $token');
      }
    });
  }
}
