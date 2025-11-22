import 'package:flutter/material.dart';
import 'package:the_meal/api_service.dart';
import 'package:the_meal/models/meal_details.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailsPage extends StatefulWidget {
  final String mealId;
  const MealDetailsPage({super.key, required this.mealId});

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage> {
  final _apiService = ApiService();
  MealDetails meal = MealDetails(
    id: '',
    name: '',
    image: '',
    instructions: '',
    youtubeLink: '',
  );

  @override
  void initState() {
    super.initState();
    fetchMeal();
  }

  Future fetchMeal() async {
    var mealDetails = await _apiService.fetchMealDetailsById(widget.mealId);
    setState(() {
      meal = mealDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("${meal.name} Meal"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 20.0),
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.network(meal.image),
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.pink.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Meal name: ${meal.name}',
                  style: const TextStyle(fontSize: 16),
                  maxLines: null,
                  softWrap: true,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Meal ID: ${meal.id}',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () async {
                      final url = Uri.parse(meal.youtubeLink);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    child: Text(
                      'Youtube link',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.pink.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Meal instructions: ${meal.instructions}',
                  maxLines: null,
                  softWrap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
