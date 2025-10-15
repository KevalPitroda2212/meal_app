import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meal_app/features/authentication/authentication_controller.dart';
import 'package:meal_app/features/authentication/init.dart';
import 'package:meal_app/features/home/home_controller.dart';
import 'package:meal_app/network/api_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ApiManager.init();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD_iFXRU-bMWWcx9LVLNBlgk0jI9JNPvLo",
      projectId: "meal-app-aef3c",
      storageBucket: "meal-app-aef3c.firebasestorage.app",
      messagingSenderId: "21445603843",
      appId: "1:21445603843:android:0105ab4dbc2d27308bd436",
    ),
  ).then((app) {
    FirebaseAuth.instanceFor(app: app);
    GoogleSignIn.instance.initialize(
      clientId: app.options.androidClientId,
      nonce: app.name,
      serverClientId: "21445603843-rmtcnvsj4hcdoc660u9t13sj84o3d706.apps.googleusercontent.com",
    );
  }).catchError((error) {
    print("Failed to initialize Firebase: $error");
  });
  Get.put(AuthenticationController());
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Meal App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: InitScreen(),
    );
  }
}

