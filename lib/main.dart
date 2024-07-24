import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          'AIzaSyARy85uW_sio4sJUocdDxit3YNTmTL6FOI', // Ganti dengan apiKey dari Firebase Console
      appId:
          '1:741292122291:android:f19c42072716c5248b90c6', // Ganti dengan appId dari Firebase Console
      messagingSenderId:
          '741292122291', // Ganti dengan messagingSenderId dari Firebase Console
      projectId:
          'inventory-app-30d93', // Ganti dengan projectId dari Firebase Console
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
