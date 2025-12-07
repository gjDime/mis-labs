import 'package:flutter/material.dart';
import 'package:the_meal/models/meal.dart';
import 'package:the_meal/services/favourites_service.dart';

class MealCard extends StatefulWidget {
  final Meal meal;
  const MealCard({super.key, required this.meal});

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  final _favouritesService = FavouritesService();
  bool _isFavourite = false;

  @override
  void initState() {
    super.initState();
    _checkFavourite();
  }

  Future _checkFavourite() async {
    final isFav = await _favouritesService.isFavourite(widget.meal.id);
    setState(() {
      _isFavourite = isFav;
    });
  }

  Future _toggleFavourite() async {
    if (_isFavourite) {
      await _favouritesService.removeFavourite(widget.meal.id);
    } else {
      await _favouritesService.addFavourite(widget.meal);
    }

    setState(() {
      _isFavourite = !_isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, "/meal", arguments: widget.meal.id),
        child: Ink.image(
          image: NetworkImage(widget.meal.image),
          fit: BoxFit.cover,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Text(
                  widget.meal.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    _isFavourite ? Icons.favorite : Icons.favorite_border,
                  ),
                  color: _isFavourite ? Colors.red : Colors.white,
                  onPressed: _toggleFavourite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
