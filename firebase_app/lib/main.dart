import 'package:firebase_app/CRUD/crud_page.dart';
import 'package:firebase_app/bindings/binding.dart';
import 'package:firebase_app/controllers/login_controller.dart';
import 'package:firebase_app/controllers/profile_controller.dart';
import 'package:firebase_app/login/login_page.dart';
import 'package:firebase_app/notif/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Handler untuk menerima pesan di background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Pesan diterima di background: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase berdasarkan platform
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyD6bGKBpGQZMQRw7sNAn3nn1Sdg5G4KUME",
        authDomain: "fir-project-1bfc4.firebaseapp.com",
        projectId: "fir-project-1bfc4",
        storageBucket: "fir-project-1bfc4.appspot.com", // Perbaiki URL storageBucket
        messagingSenderId: "986512622672",
        appId: "1:986512622672:web:735e2f9e36e9b10687fd55",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  // Inisialisasi pesan di background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Inisialisasi NotificationService
  final notificationService = NotificationService();
  await notificationService.initialize();

  // Menggunakan GetX untuk mengelola controller
  Get.put(LoginController());
  final ProfileController profileController = Get.put(ProfileController());

  // Fetch data profil jika pengguna sudah login
  if (profileController.user.value != null) {
    await profileController.fetchProfileData(profileController.user.value!.uid);
  }

  // Jalankan aplikasi
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
      initialBinding: Binding(), // Binding awal
      home: _getInitialPage(), // Halaman awal tergantung status login
      routes: {
        '/login': (context) => LoginPage(),
        // Tambahkan route lainnya jika diperlukan
      },
    );
  }

  Widget _getInitialPage() {
    // Tentukan halaman awal berdasarkan status login
    final ProfileController profileController = Get.find();
    return profileController.user.value != null
        ? CrudPage() // Jika sudah login, langsung ke CRUD page
        : LoginPage(); // Jika belum login, tampilkan halaman login
  }
}
