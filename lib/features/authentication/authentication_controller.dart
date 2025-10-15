import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meal_app/features/authentication/authentication_screen.dart';
import 'package:meal_app/features/home/home_screen.dart';

class AuthenticationController extends GetxController{

  User? _user;

  Future<void> checkUserLoggedIn() async {
    print("currentUSer : ${FirebaseAuth.instance.currentUser}");
    await Future.delayed(Duration.zero);
    _user = FirebaseAuth.instance.currentUser;
    if(_user == null){
      Get.offAll(AuthenticationScreen());
    } else {
      Get.offAll(HomeScreen());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      if(GoogleSignIn.instance.supportsAuthenticate() == false){
        return;
      }
      final GoogleSignInAccount? googleUser = await GoogleSignIn.instance.authenticate(
        scopeHint: ['email'],
      );
      if (googleUser == null){
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      _user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      Get.offAll(HomeScreen());
      // await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
        debugPrint('Error: $e');
    }
  }

  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await FirebaseAuth.instance.signOut();
    Get.offAll(AuthenticationScreen());
  }
}