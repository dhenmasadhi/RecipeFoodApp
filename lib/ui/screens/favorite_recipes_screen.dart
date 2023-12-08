// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipefoodapp/providers/recipe_provider.dart';
import 'package:recipefoodapp/ui/screens/search_recipe_screen.dart';
import 'package:recipefoodapp/ui/widgets/drawer.dart';
import 'package:recipefoodapp/ui/widgets/popup_menu_button.dart';
import 'package:recipefoodapp/ui/widgets/recipe_widget.dart';

class FavoriteRecipesScreen extends StatelessWidget {
  const FavoriteRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
        builder: (BuildContext context, myProvider, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('My Recipes'),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Favorite Recipes:',
                style: TextStyle(
                  fontSize: 16,
                  color: !myProvider.isDark ? Colors.white : null,
                ),
              )
            ],
          ),
          actions: [
            // to search in favorit list
            InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => SearchRecipeScreen(
                        recipes: myProvider.favoriteRecipes)))),
                child: const Icon(Icons.search)),

            const MyPopupMenuButton(),
          ],
        ),
        drawer: Drawer(
          backgroundColor: !myProvider.isDark ? Colors.green[100] : null,
          child: DrawerList(),
        ),
        // to show all favorite recipe in list
        body: ListView.builder(
            itemCount: myProvider.favoriteRecipes.length,
            itemBuilder: (context, index) {
              return RecipeWidget(myProvider.favoriteRecipes[index]);
            }),
      );
    });
  }
}
