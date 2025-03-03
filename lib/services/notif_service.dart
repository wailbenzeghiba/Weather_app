// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class notifService {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  //initialize the notification service
  Future<void> initNotification() async {
    if (_isInitialized) return; // return if already initialized
    //initialize timezones
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    //initialize timezones end
    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/atmosphere');
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final initSettings = InitializationSettings(android: initSettingsAndroid, iOS: initSettingsIOS);

    await notificationsPlugin.initialize(initSettings);
    _isInitialized = true;
    print('Notification service initialized');
  }

  //Notification details
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'daily_notification_channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  //Show notification
  Future<void> showNotification({required String title, required String body, required int id}) async {
    await notificationsPlugin.show(id, title, body, notificationDetails());
    print('Notification shown: $title - $body');
  }

  //schedule notification
  Future<void> scheduleNotification({required String title, required String body, required int id, required int hour, required int minute}) async {
    //get user time
    final now = tz.TZDateTime.now(tz.local);
    //create a time for the notification
    var scheduledTime = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    print('Scheduling notification for $scheduledTime');
    //schedule the notification
    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime, 
      notificationDetails(), // Use the notificationDetails method

      //ios specific settings
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, 
      //android specific settings
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      //notification repeat daily
      matchDateTimeComponents: DateTimeComponents.time,
    ); 
    print('Notification scheduled at $scheduledTime');
  }

  Future<void> cancelNotification(int id) async {
    await notificationsPlugin.cancelAll();
    print('All notifications canceled');
  }

  //if isNotificationOn is true, show notification at specific time
  Future<void> showScheduledNotification({required String title, required String body, required int id, required int hour, required int minute, required DateTime time, required bool isNotifOn}) async {
    if (isNotifOn == true && hour == time.hour && minute == time.minute) {
      print('Notification is on');
      return notificationsPlugin.show(id, title, body, notificationDetails());
    }
  }
}