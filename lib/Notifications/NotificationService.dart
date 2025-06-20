import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        debugPrint('Tapped payload: ${details.payload}');
      },
    );
  }

  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDateTime,
    int id = 0,
    String? payload,
    bool repeatDaily = true,
  }) async {
    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDateTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'pill_channel_id',
          'Pill Notifications',
          channelDescription: 'Notification for pill reminders',
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: DefaultStyleInformation(true, true),
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: repeatDaily ? DateTimeComponents.time : null,
      payload: payload,
    );
  }

  static Future<void> cancelNotification(int id) =>
    _notificationsPlugin.cancel(id);

  static Future<void> cancelAllNotifications() =>
    _notificationsPlugin.cancelAll();
}
