import 'package:flutter/material.dart';
import 'package:the_meal/services/api_service.dart';
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
  List<Meal> filteredMeals = [];
  final _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;
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
      filteredMeals = fetchedMeals;
    });
  }

  void _filterMeals() {
    setState(() {
      filteredMeals = _searchQuery.isEmpty ? meals : meals
          .where(
            (meal) =>
                meal.name.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    });
  }

  Future _searchMealsInApi(String query) async {
    setState(() {
      _isSearching = true;
    });
    final searchedMeals = await _apiService.searchMeals(query);
    setState(() {
      _isSearching = false;
      filteredMeals = searchedMeals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Meals Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Meals',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                _filterMeals();
              },
            ),
            filteredMeals.isEmpty && _searchQuery.isNotEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No meal found',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _isSearching
                              ? null
                              : () async {
                                  await _searchMealsInApi(_searchQuery);
                                },
                          child: _isSearching
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Search in API'),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                      itemCount: filteredMeals.length,
                      itemBuilder: (context, index) {
                        return MealCard(meal: filteredMeals[index]);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
