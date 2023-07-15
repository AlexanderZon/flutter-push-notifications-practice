import 'package:flutter/material.dart';
import 'package:push_notifications_project/screens/home_screen.dart';
import 'package:push_notifications_project/screens/message_screen.dart';
import 'package:push_notifications_project/services/push_notification_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = new GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PushNotificationService.messagesStream.listen((event) {
      print('My App: $event');

      navigatorKey.currentState?.pushNamed('message', arguments: event);

      final snackbar = SnackBar(content: Text('Producto: $event'));
      messengerKey.currentState?.showSnackBar(snackbar);

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      navigatorKey: navigatorKey, // Navegar
      scaffoldMessengerKey: messengerKey, // Snacks
      routes: {
        'home': (_) => HomeScreen(),
        'message': (_) => MessageScreen(),
      },
    );
  }
}