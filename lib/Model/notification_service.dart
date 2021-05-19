import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('noti_icon');

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid, macOS: null, iOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    tz.initializeTimeZones();
  }

  Future selectNotification(String payload) async {}

  void scheduledNotification(String message) async {
    Random random = Random();
    DateTime now = DateTime.now();
    DateTime schedule = new DateTime(now.year, now.month, now.day, now.hour + random.nextInt(24), now.minute, now.second, now.millisecond, now.microsecond);
    Duration difference = schedule.difference(now);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        '每日金句',
        message,
        tz.TZDateTime.now(tz.local).add(difference),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                channelId: '1234',
                channelName: '每日金句',
                channelDescription: 'zoned notification')),
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime, androidAllowWhileIdle: true);
  }

  void showNotification() async {
    await flutterLocalNotificationsPlugin.show(
        1,
        '每日金句',
        '祝你身體健康',
        const NotificationDetails(
            android: AndroidNotificationDetails(
                channelId: '123',
                channelName: '每日金句',
                channelDescription: 'What',
                importance: Importance.high,
                priority: Priority.high)));
  }
}
