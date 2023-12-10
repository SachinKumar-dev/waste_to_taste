import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:waste_to_taste/main.dart';

class FirebaseApi{

  final _firebaseMessaging = FirebaseMessaging.instance;

  //initialize notifications
  Future<void>initNotifications()async{
  await _firebaseMessaging.requestPermission();

  //fetch token
  final fCMToken=await _firebaseMessaging.getToken();
  //print token
  print("token:-" + '$fCMToken');

  initPushNotifications();
}
//nav to diff screen when clicked on notification
void handleMessage(RemoteMessage?message){
    if(message==null){
      return;
    }
    else{
      navigatorKey.currentState?.pushNamed('/navBar',arguments: message);

    }
}
//fun to initialize bg settings
Future initPushNotifications()async{
    //if app terminated and again opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    //attach eventlisteners
  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
}

}