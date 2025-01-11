import 'package:firebase_app/CRUD/crud_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(
    apiKey: "AIzaSyD6bGKBpGQZMQRw7sNAn3nn1Sdg5G4KUME",
    authDomain: "fir-project-1bfc4.firebaseapp.com",
    projectId: "fir-project-1bfc4",
    storageBucket: "fir-project-1bfc4.firebasestorage.app",
    messagingSenderId: "986512622672",
    appId: "1:986512622672:web:735e2f9e36e9b10687fd55"));
  }else{
    await Firebase.initializeApp();
  }
  

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Firebase',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CrudPage(),
    );
  }
}