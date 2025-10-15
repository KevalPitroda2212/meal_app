import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_app/features/authentication/authentication_controller.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {


  AuthenticationController _authenticationCont = Get.find();
  @override
  void initState() {
    super.initState();
    print("firebase auth instance: ${FirebaseAuth.instance?.currentUser?.email}");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 100,),
          Image.asset("assets/images/firebase-logo.png",height: 600,),
          ElevatedButton.icon(
              onPressed: (){
                _authenticationCont.signInWithGoogle();
              },
              label: Text("Sign in with Google"),
              icon: CircleAvatar(
                backgroundColor: Colors.white,
                  maxRadius: 25,
                  child: Icon(Icons.g_mobiledata_rounded, size: 45, color: Colors.blue,)),
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: Size(250, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          Center(
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: (){
                _authenticationCont.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}