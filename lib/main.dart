import 'package:booking_room/firebase_options.dart';
import 'package:booking_room/routes.dart';
import 'package:booking_room/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Buat variable channel untuk channel notifikasi
late AndroidNotificationChannel channel;
// untuk mengecek apakah sudah diinisiasi
bool isLocalNotificationInitialized = false;
// variable local notification
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
}

setupFlutterNotifications() async {
  //jika sudah diinisiasi , hentikan!
  if (isLocalNotificationInitialized) {
    return;
  }

  // inisiasi channel
  channel = AndroidNotificationChannel(
    'tristar_channel_important',
    'Tristar Notification Importance Notifications',
    description: 'This channel is used for tristar importance notifications',
    importance: Importance.high
  );

  //inisiasi flutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // create channel
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation
    <AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  // inisiasi config firebase
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );
  isLocalNotificationInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? androidNotification = message.notification?.android;
  if (notification != null && androidNotification != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background'
        )
      )
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // inisiasi firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  // inisiasi firebase messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //request permission
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: true,
    sound: true
  );
  debugPrint('Hasil request permission = ${settings.authorizationStatus}');

  //jika diizinkan
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setupFlutterNotifications();

    // handler ketika ada payload masuk
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    // handler ketika ada payload masuk di background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // subscribe ke topic tristar
    FirebaseMessaging.instance.subscribeToTopic('tristar');

    //handle firebase token
    FirebaseMessaging.instance.getToken().then((value) {
      debugPrint('firebase token = $value');
      //simpan firebase token ke preferences
      preferences.setString('firebase_token', value!);
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!
      ),
      getPages: routes,
      initialRoute: '/',
      home: SplashScreen(),
      theme: ThemeData(
        brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      themeMode: ThemeMode.system,
    );
  }
}

