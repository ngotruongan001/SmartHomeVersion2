import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
// import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:smart_home/constants/theme_provider.dart';

import 'package:smart_home/model/bottom_bar.dart';
import 'package:smart_home/screens/Login/Login.dart';
import 'package:smart_home/screens/Widget/AntiTheft/AntiTheft.dart';
import 'package:smart_home/screens/Widget/ChartTemp/ChartDashBoard.dart';
import 'package:smart_home/screens/page/Home.dart';
import 'package:smart_home/screens/page/Room.dart';
import 'package:smart_home/screens/page/StartSplashScreen.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/viewmodel/data_provider.dart';
import 'constants/theme_data.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.data);
  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
        ),
      ));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child:  MyApp(),
    ),
  );

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
// This widget is the root of your application.

}

class _MyAppState extends State<MyApp> {
  final DatabaseReference _database = FirebaseDatabase().reference();
  late FirebaseMessaging _fcm;
  late String message;
  late String token;

  @override
  void initState() {
    super.initState();

    var initialzationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android.smallIcon,
              ),
            ));

      }
      context.read<DataProvider>().fetchApiMessage();
    });
    getToken();
    context.read<DataProvider>().fetchApiMessage();
  }
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: context.watch<ThemeProvider>().BackgroundColor,
          fontFamily: 'LeonSans',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: BottomBar(),

      );
    }

    getToken() async {
      token = (await FirebaseMessaging.instance.getToken())!;
      setState(() {
        token = token;
      });

      final DatabaseReference _database = FirebaseDatabase().reference();
      _database.child('fcm-token').set({"token": token});
    }
}
