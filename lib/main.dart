import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD_iFXRU-bMWWcx9LVLNBlgk0jI9JNPvLo",
      projectId: "meal-app-aef3c",
      storageBucket: "meal-app-aef3c.firebasestorage.app",
      messagingSenderId: "1234567890",
      appId: "1:21445603843:android:0105ab4dbc2d27308bd436",
    ),
  ).then((value) {
    print("Firebase initialized");
  }).catchError((error) {
    print("Failed to initialize Firebase: $error");
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Meal App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: InitScreen(),
    );
  }
}

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Initialization Screen'),
      ),
    );
  }
}

