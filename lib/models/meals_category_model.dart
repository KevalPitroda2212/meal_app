import 'package:meal_app/models/food_model.dart';

class MealsCategoryModel {
  List<Meals>? meals;

  MealsCategoryModel({this.meals});

  MealsCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(new Meals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meals != null) {
      data['meals'] = this.meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meals {
  String? strCategory;
  List<Food>? food;

  Meals({this.strCategory, this.food});

  Meals.fromJson(Map<String, dynamic> json) {
    strCategory = json['strCategory'];
    if (json['food'] != null) {
      food = [];
      json['food'].forEach((v) {
        food!.add(new Food.fromJson(v));
      });
    }else{
      food = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strCategory'] = this.strCategory;
    if (this.food != null) {
      data['food'] = this.food!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

