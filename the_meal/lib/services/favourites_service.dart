import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_meal/models/meal.dart';

class FavouritesService {
  static const String _favouritesKey = 'favourite_meals';

  Future<List<Meal>> getFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs
            .getStringList(_favouritesKey)
            ?.map((mealJson) => Meal.fromJsonString(mealJson))
            .toList() ??
        [];
  }

  Future<void> addFavourite(Meal meal) async {
    final prefs = await SharedPreferences.getInstance();
    final favourites = await getFavourites();

    if (!favourites.any((m) => m.id == meal.id)) {
      favourites.add(meal);
      final favouritesJson = favourites.map((m) => m.toJson()).toList();
      await prefs.setStringList(_favouritesKey, favouritesJson);
    }
  }

  Future<void> removeFavourite(String mealId) async {
    final prefs = await SharedPreferences.getInstance();
    final favourites = await getFavourites();

    favourites.removeWhere((meal) => meal.id == mealId);
    final favouritesJson = favourites.map((m) => m.toJson()).toList();
    await prefs.setStringList(_favouritesKey, favouritesJson);
  }

  Future<bool> isFavourite(String mealId) async {
    final favourites = await getFavourites();
    return favourites.any((meal) => meal.id == mealId);
  }
}
