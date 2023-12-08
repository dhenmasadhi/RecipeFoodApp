// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipefoodapp/data_repository/dbHelper.dart';
import 'package:recipefoodapp/providers/recipe_provider.dart';
import 'package:recipefoodapp/ui/screens/browse_recipes_screen.dart';
import 'package:recipefoodapp/ui/screens/favorite_recipes_screen.dart';
import 'package:recipefoodapp/ui/screens/main_recipe_screen.dart';
import 'package:recipefoodapp/ui/screens/new_recipe_screen.dart';
import 'package:recipefoodapp/ui/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<RecipeClass>(
        create: (context) => RecipeClass(),
      ),
    ], child: const InitApp());
  }
}

class InitApp extends StatelessWidget {
  const InitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<RecipeClass>(context).isDark
          ? ThemeData.dark()
          : ThemeData(
              primarySwatch: Colors.green,
              scaffoldBackgroundColor: Colors.grey[100],
              dialogBackgroundColor: Color(0xFFD9D9D9),
              primaryColor: Color(0xFFD9D9D9)),
      title: 'gsk',
      home: const SplashScreen(),
      routes: {
        '/favorite_recipes_screen': (context) => const FavoriteRecipesScreen(),
        '/new_recipe_screen': (context) => const NewRecipeScreen(),
        '/main_recipe_screen': (context) => const MainRecipeScreen(),
        '/browse_recipes_screen': (context) => const BrowseRecipes(),
      },
    );
  }
}
