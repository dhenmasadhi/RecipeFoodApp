import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipefoodapp/providers/recipe_provider.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({Key? key}) : super(key: key);

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
        builder: (BuildContext context, myProvider, Widget? child) => Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  color: !myProvider.isDark ? Colors.green : null,
                  child: const Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/food-logo.png'),
                      radius: 50,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Home'),
                  leading: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, '/main_recipe_screen');
                  },
                ),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  title: const Text('Browse'),
                  leading: const Icon(
                    Icons.explore,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, '/browse_recipes_screen');
                  },
                ),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  title: const Text('Favorite Recipes'),
                  leading: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  // to navigate to favorite page
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, '/favorite_recipes_screen');
                  },
                ),
                const Divider(
                  thickness: 1,
                ),
                Provider.of<RecipeClass>(context).isDark
                    ? ListTile(
                        title: const Text('Light Mode'),
                        leading: const Icon(
                          Icons.light_mode_outlined,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Provider.of<RecipeClass>(context, listen: false)
                              .changeIsDark();
                          Navigator.pop(context);
                        },
                      )
                    : ListTile(
                        title: const Text('Dark Mode'),
                        leading: const Icon(
                          Icons.dark_mode_outlined,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Provider.of<RecipeClass>(context, listen: false)
                              .changeIsDark();
                          Navigator.pop(context);
                        },
                      ),
              ],
            ));
  }
}
