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
  final _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final fetchedCategories = await _apiService.fetchCategories();
    setState(() {
      categories.addAll(fetchedCategories);
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
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryCard(category: categories[index]);
          },
        ),
      ),
    );
  }
}
