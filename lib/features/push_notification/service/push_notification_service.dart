import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:labamu/features/push_notification/domain/repository/push_notification_repository.dart';

// class PushNotificationService implements PushNotificationRepository {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   @override
//   Future<String> getDeviceToken() async {
//     return await _firebaseMessaging.getToken() ?? "";
//   }

//   @override
//   void configurePushNotifications() {
//     _firebaseMessaging.requestPermission(
//       sound: true,
//       badge: true,
//       alert: true,
//     );
//     _firebaseMessaging.setForegroundNotificationPresentationOptions(
//       sound: true,
//       badge: true,
//       alert: true,
//     );
//     // FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
//   }

//   static Future<dynamic> myBackgroundMessageHandler(
//       RemoteMessage message) async {
//     print("Handling a background message: $message");
//     // Handle incoming message when the app is in the background
//   }

//   @override
//   void subscribeToTopic(String topic) {
//     _firebaseMessaging.subscribeToTopic(topic);
//   }

//   @override
//   void unsubscribeFromTopic(String topic) {
//     _firebaseMessaging.unsubscribeFromTopic(topic);
//   }
// }

class PushNotificationService implements PushNotificationRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<String> getDeviceToken() async {
    return await _firebaseMessaging.getToken() ?? "";
  }

  @override
  void configurePushNotifications() async {
    await _firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 Foreground message: ${message.notification?.title}");
      _showLocalNotification(message);
    });

    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      sound: true,
      badge: true,
      alert: true,
    );

    _initializeLocalNotifications();

    // FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  }

  void _initializeLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    _localNotificationsPlugin.initialize(initSettings);

    const androidChannel = AndroidNotificationChannel(
      'default_channel', // Harus sama seperti di AndroidNotificationDetails
      'PMB NF Notifications',
      description: 'This channel is used for PMB NF notifications.',
      importance: Importance.high,
    );

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidChannel);
  }

  void _showLocalNotification(RemoteMessage message) {
    const androidDetails = AndroidNotificationDetails(
      'default_channel', // Must match NotificationChannel ID on Android 8.0+
      'PMB NF Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const generalNotificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    _localNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? 'No title',
      message.notification?.body ?? 'No body',
      generalNotificationDetails,
    );
  }

  static Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
    print("📩 Background message: ${message.notification?.title}");
    // You can show local notification here in background/terminated with plugins like workmanager if needed
  }

  @override
  void subscribeToTopic(String topic) {
    _firebaseMessaging.subscribeToTopic(topic);
  }

  @override
  void unsubscribeFromTopic(String topic) {
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
