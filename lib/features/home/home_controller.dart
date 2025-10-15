import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meal_app/models/food_model.dart';
import 'package:meal_app/models/meals_category_model.dart';
import 'package:meal_app/network/api_manager.dart';

class HomeController extends GetxController{

  MealsCategoryModel? mealsCategoryModel;

  late PageController pageController;
  int selectedIndex = 0;

  MealsCategoryModel? get getMealsCategoryModel => mealsCategoryModel;
  set setMealsCategoryModel(MealsCategoryModel? val) {
    mealsCategoryModel = val;
  }

  PageController get getPageController => pageController;
  set setPageController(PageController val) {
    pageController = val;
  }

  int get getSelectedIndex => selectedIndex;
  set setSelectedIndex(int val) {
    selectedIndex = val;
  }

  getMealsCategoriesWithItems() async {
    ApiManager.getMealsCategory().then((value) {
      if(value != null){
        mealsCategoryModel = value;
        getAllFoodByCategory();
      } else{
        mealsCategoryModel!.meals = [];
      }
      update();
    });
  }

  updateQty(Food food, bool isAdd) {
    for (final meal in mealsCategoryModel!.meals!) {
      final index = meal.food!.indexWhere((f) => f.idMeal == food.idMeal);
      if (index != -1) {
        final targetFood = meal.food![index];

        if (isAdd) {
          targetFood.qty = (targetFood.qty ?? 0) + 1;
        } else {
          if ((targetFood.qty ?? 0) > 0) {
            targetFood.qty = (targetFood.qty ?? 0) - 1;
          }
        }

        update();
        break;
      }
    }
  }


  // updateQty(int categoryIndex, int foodIndex, bool isAdd){
  //   if(isAdd){
  //     mealsCategoryModel!.meals![categoryIndex].food![foodIndex].qty = (mealsCategoryModel!.meals![categoryIndex].food![foodIndex].qty ?? 0) + 1;
  //   } else{
  //     if((mealsCategoryModel!.meals![categoryIndex].food![foodIndex].qty ?? 0) > 0){
  //       mealsCategoryModel!.meals![categoryIndex].food![foodIndex].qty = (mealsCategoryModel!.meals![categoryIndex].food![foodIndex].qty ?? 0) - 1;
  //     }
  //   }
  //   update();
  //
  // }

  getAllFoodByCategory() async {
    for(Meals meal in mealsCategoryModel!.meals!){
      await  ApiManager.getFoodByCategory(category: meal.strCategory).then((value) {
        if(value != null){
          mealsCategoryModel!.meals!.where((v) => v.strCategory == meal.strCategory).first.food = value.food;
        }
        update();
      });
    }
  }

}