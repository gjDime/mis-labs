import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:the_meal/models/category.dart';
import 'package:the_meal/models/meal.dart';
import 'package:the_meal/models/meal_details.dart';

class ApiService {
  static const String baseUrl = "https://www.themealdb.com/api/json/v1/1/";

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse("${baseUrl}categories.php"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final List categoriesJson = data['categories'] ?? [];

      return categoriesJson.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Meal>> fetchMealsByCategory(String category) async {
    final response = await http.get(
      Uri.parse("${baseUrl}filter.php?c=$category"),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final List mealsJson = data['meals'] ?? [];

      return mealsJson.map((json) => Meal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load meals for category $category');
    }
  }

  Future<MealDetails> fetchMealDetailsById(String id) async {
    final response = await http.get(Uri.parse("${baseUrl}lookup.php?i=$id"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final List mealsJson = data['meals'] ?? [];

      if (mealsJson.isNotEmpty) {
        return MealDetails.fromJson(mealsJson[0]);
      } else {
        throw Exception('Meal not found for id $id');
      }
    } else {
      throw Exception('Failed to load meal details for id $id');
    }
  }
}
