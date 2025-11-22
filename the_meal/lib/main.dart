import 'package:flutter/material.dart';
import 'package:the_meal/models/meal.dart';
import 'package:the_meal/screens/categories.dart';
import 'package:the_meal/screens/meal_details.dart';
import 'package:the_meal/screens/meals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => const CategoriesPage(),
        "/meals": (context) {
          final categoryName =
              ModalRoute.of(context)!.settings.arguments as String;
          return MealsPage(category: categoryName);
        },
        "/meal": (context) {
          final mealId = ModalRoute.of(context)!.settings.arguments as String;
          return MealDetailsPage(mealId: mealId);
        },
      },
    );
  }
}
