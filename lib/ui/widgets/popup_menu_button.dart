import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipefoodapp/providers/recipe_provider.dart';

class MyPopupMenuButton extends StatefulWidget {
  const MyPopupMenuButton({Key? key}) : super(key: key);

  @override
  State<MyPopupMenuButton> createState() => _MyPopupMenuButtonState();
}

class _MyPopupMenuButtonState extends State<MyPopupMenuButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
      builder: (BuildContext context, myProvider, Widget? child) =>
          PopupMenuButton(
        color: !myProvider.isDark ? Colors.green[100] : null,
        itemBuilder: ((context) => [
              PopupMenuItem(
                onTap: (() => Scaffold.of(context).openDrawer()),
                child: const Text('Open Menu'),
              ),
              const PopupMenuItem(
                child: Text('About'),
              ),
              PopupMenuItem(
                onTap: (() => exit(0)),
                // ignore: prefer_const_constructors
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // ignore: prefer_const_constructors
                    Row(
                      children: const [
                        Icon(Icons.exit_to_app_outlined, color: Colors.red),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Exit')
                      ],
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
