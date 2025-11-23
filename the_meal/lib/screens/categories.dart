import 'package:flutter/material.dart';
import 'package:the_meal/api_service.dart';
import 'package:the_meal/models/category.dart';
import 'package:the_meal/widgets/category_card.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final List<Category> categories = [];
  List<Category> filteredCategories = [];
  final _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future _fetchCategories() async {
    final fetchedCategories = await _apiService.fetchCategories();
    setState(() {
      categories.addAll(fetchedCategories);
      filteredCategories.addAll(fetchedCategories);
    });
  }

  void _filterCategories(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredCategories = categories;
      });
      return;
    }

    final filtered = categories
        .where(
          (category) =>
              category.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    setState(() {
      filteredCategories = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('The Meal App'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search cateogies',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: _filterCategories,
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  return CategoryCard(category: filteredCategories[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/meal');
        },
        child: const Icon(Icons.shuffle),
      ),
    );
  }
}
