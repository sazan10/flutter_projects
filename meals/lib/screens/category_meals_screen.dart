import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  // final String categoryId;
  // final String categoryTitle;
  // const CategoryMealsScreen(this.categoryId,this.categoryTitle);
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);
  static String categoryRoute = '/category-meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var initMeals = true;
@override
void initState() { 
  super.initState();
  
}
  @override
  void didChangeDependencies() {
    if (initMeals) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
    }
    initMeals = false;
  }

  // void _removeMeal(String mealId) {
  //   setState(() {
  //     displayedMeals.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            imageUrl: displayedMeals[index].imageUrl,
            // removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
