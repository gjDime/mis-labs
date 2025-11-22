import 'package:flutter/material.dart';
import 'package:the_meal/api_service.dart';
import 'package:the_meal/models/meal.dart';
import 'package:the_meal/widgets/meal_card.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key, required this.category});

  final String category;

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  List<Meal> meals = [];
  final _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchMeals();
  }

  Future _fetchMeals() async {
    final fetchedMeals = await _apiService.fetchMealsByCategory(
      widget.category,
    );
    setState(() {
      meals = fetchedMeals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Meals Page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: meals.length,
          itemBuilder: (context, index) {
            return MealCard(meal: meals[index]);
          },
        ),
      ),
    );
  }
}
