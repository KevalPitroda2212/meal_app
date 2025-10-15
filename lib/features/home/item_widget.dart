import 'package:flutter/material.dart';
import 'package:meal_app/features/home/home_controller.dart';
import 'package:meal_app/models/food_model.dart';

class ItemWidget extends StatelessWidget {
  Food? food;
  HomeController homeCont;
  ItemWidget({super.key, this.food, required this.homeCont});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade50,

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${food!.strMeal}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  'INR : ${food!.idMeal}',
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  'description',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red,),
                      onPressed: (){
                        homeCont.updateQty(food!, false);
                      },
                    ),
                    Text("${food!.qty ?? 0}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                    IconButton(
                      icon: Icon(Icons.add_circle, color: Colors.green,),
                      onPressed: (){
                        homeCont.updateQty(food!, true);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 20,),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(food!.strMealThumb!, height: 90, width: 90,),
          ),
        ],
      ),
    );
  }
}
