import 'dart:convert';

class Meal {
  final String id;
  final String name;
  final String image;

  Meal({required this.id, required this.name, required this.image});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      image: json['strMealThumb'] as String,
    );
  }

  factory Meal.fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return Meal.fromJson(json);
  }

  String toJson() {
    return jsonEncode({'idMeal': id, 'strMeal': name, 'strMealThumb': image});
  }
}
