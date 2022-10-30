import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/data/models/restaurant_model.dart';
import 'package:restaurant_app/pages/detail_page.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;
        if (payload != null) {
          print('notification payload: $payload');
        }
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "restaurant channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    var restaurants = await ApiService().restaurantList(http.Client());
    var randomIndex = Random().nextInt(restaurants.restaurants.length);
    var randomRestaurant = restaurants.restaurants[randomIndex];

    var titleNotification = "<b>Restaurant Recommendation!</b>";
    var titleRestaurant = randomRestaurant.name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleRestaurant,
      platformChannelSpecifics,
      payload: json.encode(randomRestaurant.toJson()),
    );
  }

  void configureSelectNotificationSubject(BuildContext context) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = Restaurant.fromJson(json.decode(payload));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(data.id),
          ),
        );
      },
    );
  }
}
