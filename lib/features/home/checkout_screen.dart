import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_app/features/home/home_controller.dart';
import 'package:meal_app/features/home/item_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout Screen"),
      ),
      body: GetBuilder<HomeController>(
          builder: (homeCont) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: homeCont.getMealsCategoryModel?.meals
                        ?.where((meal) => meal.food != null && meal.food!.any((food) => (food.qty ?? 0) > 0))
                        .fold(0, (sum, meal) => sum! + meal.food!.where((food) => (food.qty ?? 0) > 0).length) ?? 0,
                    itemBuilder: (context, index) {
                      final foodItems = homeCont.getMealsCategoryModel?.meals
                          ?.expand((meal) => meal.food ?? [])
                          .where((food) => (food.qty ?? 0) > 0)
                          .toList() ?? [];
                      final item = foodItems[index];
                      return ItemWidget(homeCont: homeCont, food: item,);
                    },
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  margin: EdgeInsets.all(20),
                  child: Text("Total Amount: ${homeCont.mealsCategoryModel!.meals!
                      .expand((meal) => meal.food!)
                      .fold(0, (sum, food) => sum + ((int.parse(food.idMeal!) ?? 0) * (food.qty ?? 0)))}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ),
              ],
            );
          }
      ),
    );
  }
}
