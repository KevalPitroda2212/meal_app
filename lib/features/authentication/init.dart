import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meal_app/features/authentication/authentication_controller.dart';
import 'package:meal_app/features/authentication/authentication_screen.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {

  AuthenticationController _authenticationCont = Get.find();

  @override
  void initState() {
    super.initState();
    _authenticationCont.checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Initialization Screen'),
      ),
      body: Container(),
    );
  }
}