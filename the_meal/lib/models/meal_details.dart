class MealDetails {
  final String id;
  final String name;
  final String image;
  final String instructions;
  final String youtubeLink;
  MealDetails({
    required this.id,
    required this.name,
    required this.image,
    required this.instructions,
    required this.youtubeLink,
  });
  MealDetails.fromJson(Map<String, dynamic> json)
    : id = json['idMeal'] as String,
      name = json['strMeal'] as String,
      image = json['strMealThumb'] as String,
      instructions = json['strInstructions'] as String,
      youtubeLink = json['strYoutube'] as String;
}
