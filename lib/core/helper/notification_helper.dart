import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/config.dart';
import 'package:lms_user_app/controller/auth_controller.dart';
import 'package:lms_user_app/core/helper/help_me.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class NotificationHelper {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onSelectNotification: (String? payload) async {
      printLog("payload:$payload");
      try {
        if (payload != null && payload.isNotEmpty) {
          // Get.toNamed(RouteHelper.getBookingDetailsScreen(payload,'fromNotification'));
        } else {
          //Get.toNamed(RouteHelper.getNotificationRoute());
        }
      } catch (e) {
        //
      }
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      printLog(
          "onMessage: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      // NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, false);
      if (Get.find<AuthController>().isLoggedIn()) {
        // Get.find<NotificationController>().getNotification(1);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      try {
        if (message.notification!.titleLocKey != null &&
            message.notification!.titleLocKey!.isNotEmpty) {
          // Get.toNamed(RouteHelper.getBookingDetailsScreen(message.notification!.titleLocKey!,'fromNotification'));
        } else {
          //Get.toNamed(RouteHelper.getNotificationRoute());
        }
      } catch (e) {
        //
      }
    });
  }

  static Future<void> showNotification(RemoteMessage message,
      FlutterLocalNotificationsPlugin fln, bool data) async {
    if (!GetPlatform.isIOS) {
      String? title;
      String? body;
      String? orderID;
      String? image;
      if (data) {
        title = message.data['title'];
        body = message.data['body'];
        orderID = message.data['booking_id'].toString();
        image = (message.data['image'] != null &&
                message.data['image'].isNotEmpty)
            ? message.data['image'].startsWith('http')
                ? message.data['image']
                : '${Config.baseUrl}/storage/app/public/notification/${message.data['image']}'
            : null;
      } else {
        title = message.notification!.title;
        body = message.notification!.body;
        orderID = message.notification!.titleLocKey;
        if (GetPlatform.isAndroid) {
          image = (message.notification!.android!.imageUrl != null &&
                  message.notification!.android!.imageUrl!.isNotEmpty)
              ? message.notification!.android!.imageUrl!.startsWith('http')
                  ? message.notification!.android!.imageUrl
                  : '${Config.baseUrl}/storage/app/public/notification/${message.notification!.android!.imageUrl}'
              : null;
        } else if (GetPlatform.isIOS) {
          image = (message.notification!.apple!.imageUrl != null &&
                  message.notification!.apple!.imageUrl!.isNotEmpty)
              ? message.notification!.apple!.imageUrl!.startsWith('http')
                  ? message.notification!.apple!.imageUrl
                  : '${Config.baseUrl}/storage/app/public/notification/${message.notification!.apple!.imageUrl}'
              : null;
        }
      }

      if (image != null && image.isNotEmpty) {
        try {
          await showBigPictureNotificationHiddenLargeIcon(
              title!, body!, orderID!, image, fln);
        } catch (e) {
          // await showBigTextNotification(_title!, _body!, _orderID!, fln);
          await showBigTextNotification(title!, '  ', orderID!, fln);
        }
      } else {
        await showBigTextNotification(title!, '  ', orderID!, fln);
      }
    }
  }

  static Future<void> showTextNotification(String title, String body,
      String orderID, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'onlms',
      'onlms',
      playSound: true,
      importance: Importance.max,
      priority: Priority.max,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<void> showBigTextNotification(String title, String body,
      String orderID, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'onlms',
      'onlms',
      importance: Importance.max,
      styleInformation: bigTextStyleInformation,
      priority: Priority.max,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
      String title,
      String body,
      String orderID,
      String image,
      FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath =
        await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'onlms',
      'onlms',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      priority: Priority.max,
      playSound: true,
      styleInformation: bigPictureStyleInformation,
      importance: Importance.max,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  printLog(
      "onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
}
