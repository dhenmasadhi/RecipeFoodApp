// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:recipefoodapp/providers/recipe_provider.dart';
import 'package:recipefoodapp/ui/screens/search_recipe_screen.dart';
import 'package:recipefoodapp/ui/widgets/drawer.dart';
import 'package:recipefoodapp/ui/widgets/popup_menu_button.dart';
import 'package:recipefoodapp/ui/widgets/recipe_widget.dart';

class MainRecipeScreen extends StatelessWidget {
  const MainRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
      builder: (BuildContext context, myProvider, Widget? child) => Scaffold(
        appBar: AppBar(
          title: const Text('My Recipes'),
          actions: [
            InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) =>
                        SearchRecipeScreen(recipes: myProvider.allRecipes)))),
                child: const Icon(Icons.search)),
            const MyPopupMenuButton(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() async {
            await Navigator.pushNamed(context, '/new_recipe_screen');
            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, '/main_recipe_screen');
          }),
          child: const Icon(Icons.add),
        ),
        drawer: Drawer(
          backgroundColor: !myProvider.isDark ? Colors.green[100] : null,
          child: const DrawerList(),
        ),
        body: ListView(
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
              decoration: BoxDecoration(
                color: !myProvider.isDark ? Colors.green : Colors.grey[800],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 3,
                      bottom: 5,
                    ),
                    child: Text(
                      "Welcome,",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                        wordSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 3,
                      bottom: 15,
                    ),
                    child: Text(
                      "What are you cooking today?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                        wordSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      // height: 400.0,
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                    ),
                    items: [
                      "images/image1.jpg",
                      "images/image2.jpg",
                      "images/image3.jpg",
                      "images/image4.jpg",
                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(16)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                i,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              children: [
                const Text(
                  "Recipe List",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: myProvider.allRecipes.length,
                  itemBuilder: (context, index) {
                    return RecipeWidget(myProvider.allRecipes[index]);
                  },
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
