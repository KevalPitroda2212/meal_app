class FoodModel {
  List<Food>? food;

  FoodModel({this.food});

  FoodModel.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      food = <Food>[];
      json['meals'].forEach((v) {
        food!.add(new Food.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.food != null) {
      data['meals'] = this.food!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Food {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;
  String? baseCategory;
  int? qty;
  bool? active;

  Food({this.strMeal, this.strMealThumb, this.idMeal, this.qty, this.active});

  Food.fromJson(Map<String, dynamic> json) {
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    idMeal = json['idMeal'];
    qty = json['qty'];
    baseCategory = json['baseCategory'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strMeal'] = this.strMeal;
    data['strMealThumb'] = this.strMealThumb;
    data['idMeal'] = this.idMeal;
    data['qty'] = this.qty;
    data['baseCategory'] = this.baseCategory;
    data['active'] = this.active;
    return data;
  }
}
