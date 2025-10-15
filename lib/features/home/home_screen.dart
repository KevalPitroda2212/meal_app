import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_app/features/authentication/authentication_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen"),
        actions: [
          GetBuilder<AuthenticationController>(
            builder: (_authenticationCont) {
              return Center(
                child: IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: (){
                    _authenticationCont.signOut();
                  },
                ),
              );
            }
          ),
        ],
      ),
      body: Text("Home"),
    );
  }
}
