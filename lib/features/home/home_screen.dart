// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:meal_app/features/authentication/authentication_controller.dart';
// import 'package:meal_app/network/api_manager.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Home Screen"),
//         actions: [
//           GetBuilder<AuthenticationController>(
//             builder: (_authenticationCont) {
//               return Center(
//                 child: IconButton(
//                   icon: Icon(Icons.logout),
//                   onPressed: (){
//                     _authenticationCont.signOut();
//                     // ApiManager.getMeals();
//                   },
//                 ),
//               );
//             }
//           ),
//         ],
//       ),
//       body: Text("Home"),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_app/features/authentication/authentication_controller.dart';
import 'package:meal_app/features/home/checkout_screen.dart';
import 'package:meal_app/features/home/home_controller.dart';
import 'package:meal_app/features/home/item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeController _homeCont = Get.find();

  // late PageController _pageController;
  // int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _homeCont.pageController = PageController(initialPage: _homeCont.selectedIndex);
    _homeCont.getMealsCategoriesWithItems();
  }

  @override
  void dispose() {
    _homeCont.pageController.dispose();
    super.dispose();
  }

  void _onCategorySelected(int index) {
    setState(() => _homeCont.selectedIndex = index);
    _homeCont.pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GetBuilder<AuthenticationController>(
          builder: (_authenticationCont) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // 🧑 User Header
                GetBuilder<HomeController>(
                    builder: (homeCont) {
                    return UserAccountsDrawerHeader(
                      accountName: Text("${FirebaseAuth.instance.currentUser?.displayName}"),
                      accountEmail: Text("${FirebaseAuth.instance.currentUser?.email}"),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser?.photoURL ?? ""), // optional
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                      ),
                    );
                  }
                ),

                // 📋 Drawer menu items
                ListTile(
                  leading: const Icon(Icons.logout,),
                  title: const Text("LogOut",),
                  onTap: () {
                    _authenticationCont.signOut();
                  },
                ),
              ],
            ),
          );
        }
      ),
      appBar: AppBar(
        title: const Text('Category View'),
        actions: [
          GetBuilder<HomeController>(
            builder: (homeCont) {
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: (){
                      Get.to(CheckoutScreen());
                    },
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    child: _homeCont.mealsCategoryModel == null ? Text("") : Text("${_homeCont.mealsCategoryModel!.meals!.fold(0, (sum, meal) => sum + meal.food!.fold(0, (foodSum, food) => foodSum + (food.qty ?? 0)))}", style: TextStyle(fontSize: 10, color: Colors.white),),
                    maxRadius: 8,
                  ),
                ],
              );
            }
          ),
        ],
      ),
      body: GetBuilder<HomeController>(
        builder: (homeCont) {
          return _homeCont.mealsCategoryModel == null ? Center(child: CircularProgressIndicator()) : Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 55,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeCont.mealsCategoryModel!.meals!.length,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: (context, index) {
                        final isSelected = _homeCont.selectedIndex == index;
                        return GestureDetector(
                          onTap: () => _onCategorySelected(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: isSelected ? Border(bottom: BorderSide(width: 2, color: Colors.blue)) : Border(),
                            ),
                            child: Center(
                              child: Text(
                                homeCont.mealsCategoryModel!.meals![index].strCategory!,
                                style: TextStyle(
                                  color: isSelected ? Colors.blue : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _homeCont.pageController,
                      onPageChanged: (index) {
                        setState(() => _homeCont.selectedIndex = index);
                      },
                      itemCount: 1,
                      itemBuilder: (context, ind) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _homeCont.mealsCategoryModel == null ? 0 :_homeCont.mealsCategoryModel!.meals![_homeCont.selectedIndex].food!.length,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemBuilder: (context, index){
                            final food = _homeCont.mealsCategoryModel!.meals![_homeCont.selectedIndex].food![index];
                            return ItemWidget(homeCont: homeCont, food: food,);
                          },
                        );

                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      ),
      // backgroundColor: Colors.black,
    );
  }
}
