import 'package:flutter/material.dart';
import 'package:the_meal/models/meal.dart';
import 'package:the_meal/services/favourites_service.dart';
import 'package:the_meal/widgets/meal_card.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  bool _isLoading = true;
  List<Meal> _favouriteMeals = [];
  final _favouritesService = FavouritesService();

  Future _loadFavourites() async {
    setState(() {
      _isLoading = true;
    });

    final meals = await _favouritesService.getFavourites();

    setState(() {
      _isLoading = false;
      _favouriteMeals = meals;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favouriteMeals.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No favourites yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                itemCount: _favouriteMeals.length,
                itemBuilder: (context, index) {
                  return MealCard(meal: _favouriteMeals[index]);
                },
              ),
            ),
    );
  }
}
