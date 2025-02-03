import 'package:firebase_app/CRUD/crud_page.dart';
import 'package:firebase_app/bindings/binding.dart';
import 'package:firebase_app/controllers/auth_controller.dart';
import 'package:firebase_app/controllers/profile_controller.dart';
import 'package:firebase_app/login/login_page.dart';
import 'package:firebase_app/notif/notification_service.dart';
import 'package:firebase_app/profile/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'CRUD/add_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Pesan diterima di background: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyD6bGKBpGQZMQRw7sNAn3nn1Sdg5G4KUME",
        authDomain: "fir-project-1bfc4.firebaseapp.com",
        projectId: "fir-project-1bfc4",
        storageBucket: "fir-project-1bfc4.appspot.com",
        messagingSenderId: "986512622672",
        appId: "1:986512622672:web:735e2f9e36e9b10687fd55",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final notificationService = NotificationService();
  await notificationService.initialize();

  Get.put(AuthController());
  final ProfileController profileController = Get.put(ProfileController());

  if (profileController.user.value != null) {
    await profileController.fetchProfileData(profileController.user.value!.uid);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Restoran App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialBinding: Binding(),
      home: _getInitialPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/crudPage' : (context) => CrudPage(),
        '/addMenuPage' : (context) => AddMenuPage(),
        '/profilePage' : (context) => ProfilePage(),
      },
    );
  }

  Widget _getInitialPage() {
    final ProfileController profileController = Get.find();
    return profileController.user.value != null ? CrudPage() : LoginPage();
  }
}
