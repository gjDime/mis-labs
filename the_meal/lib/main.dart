import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:the_meal/firebase_options.dart';
import 'package:the_meal/screens/categories.dart';
import 'package:the_meal/screens/favourites.dart';
import 'package:the_meal/screens/meal_details.dart';
import 'package:the_meal/screens/meals.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  String? token = await FirebaseMessaging.instance.getToken();
  print('FCM Token: $token');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Meal app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => const CategoriesPage(),
        "/meals": (context) {
          final categoryName =
              ModalRoute.of(context)!.settings.arguments as String;
          return MealsPage(category: categoryName);
        },
        "/meal": (context) {
          final mealId = ModalRoute.of(context)!.settings.arguments as String?;
          return MealDetailsPage(mealId: mealId);
        },
        "/favourites": (context) => const Favourites(),
      },
    );
  }
}
