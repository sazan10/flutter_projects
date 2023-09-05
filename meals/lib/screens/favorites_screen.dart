import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List <Meal> favoriteMeals;

  const FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if(favoriteMeals.isEmpty)
    {
    return Container(
      child: Text("Favorites"),
    );
    }
    else{
      return  ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            title: favoriteMeals[index].title,
            duration: favoriteMeals[index].duration,
            complexity: favoriteMeals[index].complexity,
            affordability: favoriteMeals[index].affordability,
            imageUrl: favoriteMeals[index].imageUrl,
            // removeItem: _removeMeal,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}