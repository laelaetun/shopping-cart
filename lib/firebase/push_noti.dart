import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging messaging = FirebaseMessaging.instance;

void setupFCM() async {
  await messaging.requestPermission();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message while in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
}
