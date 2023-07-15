import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notifications_project/firebase_options.dart';

class PushNotificationService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream = StreamController();
  static Stream<String> get messagesStream => _messageStream.stream;

  // Esta funcion es async por si es necesario hacer un cambio en base de datos u otros procesos asincronos
  static Future _backgroundHandler(RemoteMessage message) async {
    // print('background handler ${ message.messageId }');
    print(message.data);
    // _messageStream.add(message.notification?.title ?? 'No title');
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    // print('onMessage handler ${ message.messageId }');
    print(message.data);
    // _messageStream.add(message.notification?.title ?? 'No title');
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _onMessageOpenAppHandler(RemoteMessage message) async {
    // print('onMessageOpenApp handler ${ message.messageId }');
    print(message.data);
    // _messageStream.add(message.notification?.title ?? 'No title');
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future initializeApp() async {    
    // Push notifications
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );

    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    // Handlers
    
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageHandler);

    // Local Notifications
  }

  static closeStreams () {
    _messageStream.close();
  }

}