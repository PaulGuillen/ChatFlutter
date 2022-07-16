import 'package:chat_flutter/src/models/users.dart';
import 'package:chat_flutter/src/pages/home/home_page.dart';
import 'package:chat_flutter/src/pages/login/login_page.dart';
import 'package:chat_flutter/src/pages/messages/messages_pages.dart';
import 'package:chat_flutter/src/pages/profile_edit/profile_edit_page.dart';
import 'package:chat_flutter/src/pages/register/register_page.dart';
import 'package:chat_flutter/src/provider/push_notifications_provider.dart';
import 'package:chat_flutter/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:chat_flutter/src/utils/default_firebase_config.dart';

User myUser = User.fromJson(GetStorage().read('user') ?? {});
PushNotificationsProvider pushNotificationsProvider =
    PushNotificationsProvider();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // NOTIFICACIONES EN SEGUNDO PLANO
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  print('Notificacion en segundo plano ${message.messageId}');
  print('NUEVA NOTIFICACION BACKGROUND ${message.data}');

  //
  // pushNotificationsProvider.showNotification(message);

/*  Socket socket = io('${Environment.API_CHAT}chat', <String, dynamic> {
    'transports': ['websocket'],
    'autoConnect': false
  });*/
/*  socket.connect();
  socket.emit('received', {
    'id_chat': message.data['id_chat'],
    'id_message': message.data['id_message'],
  });*/
}

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBJYUFaJAUoMcviyjnrml9PslaKu-0ifMc',
      appId: '1:583482011417:android:175bddb2eeca9dae05df88',
      messagingSenderId: '583482011417',
      projectId: 'flutterchat-7733a',
    ),
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  pushNotificationsProvider.initPushNotifications();
  runApp(MyApp());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pushNotificationsProvider.onMessageListener();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chat App Flutter',
      debugShowCheckedModeBanner: false,
      initialRoute: myUser.id != null ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/profile/edit', page: () => ProfileEditPage()),
        GetPage(name: '/messages', page: () => MessagesPage()),
      ],
      theme: ThemeData(
          // colorScheme: const ColorScheme.light().copyWith(primary: MyColors.primaryColor),
          primaryColor: MyColors.primaryColor),
      navigatorKey: Get.key,
    );
  }
}
