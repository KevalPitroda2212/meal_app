import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meal_app/models/food_model.dart';
import 'package:meal_app/models/meals_category_model.dart';

class ApiManager{

  static Dio? dio;

  static init() {
    dio = Dio();
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  static Future<MealsCategoryModel?> getMealsCategory() async {

    debugPrint("getMealsCategory called");
    final response = await dio!.get("https://www.themealdb.com/api/json/v1/1/list.php?c=list");

    print("${response.statusCode}");
    if(response.statusCode == 200){
      return MealsCategoryModel.fromJson(response.data);
    }else{
      return null;
    }
  }

  static Future<FoodModel?> getFoodByCategory({String? category}) async {
    debugPrint("getFoodByCategory called => $category");
    final response = await dio!.get("https://www.themealdb.com/api/json/v1/1/filter.php?c=$category");

    print("${response.statusCode}");
    if(response.statusCode == 200){
      return FoodModel.fromJson(response.data);
    }else{
      return null;
    }
  }

}