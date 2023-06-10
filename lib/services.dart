
// import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  /*final FirebaseMessaging _fcm;

  PushNotificationService(this._fcm);*/

  Future initialise() async {

    // If you want to test the push notification locally,
    // you need to get the token and input to the Firebase console
    // https://console.firebase.google.com/project/YOUR_PROJECT_ID/notification/compose
    /*String? token = await FirebaseMessaging.instance.getToken();
    print("FirebaseMessaging token: $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      print(message.notification!.body);
      AndroidNotification? android = message.notification?.android;
    });*/


  }
}