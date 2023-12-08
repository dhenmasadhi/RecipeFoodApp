// ignore_for_file: file_names
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:recipefoodapp/models/recipe_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  // to define all variables
  late Database database;
  static DbHelper dbHelper = DbHelper();
  final String tableName = 'recipes';
  final String nameColumn = 'name';
  final String idColumn = 'id';
  final String isFavoriteColumn = 'isFavorite';
  final String ingredientsColumn = 'ingredients';
  final String instructionsColumn = 'instructions';
  final String preperationTimeColumn = 'preperationTime';
  final String imageColumn = 'image';

  initDatabase() async {
    database = await connectToDatabase();
  }

  Future<Database> connectToDatabase() async {
    // Get location using getDatabasesPath
    Directory directory = await getApplicationDocumentsDirectory();
    // to specific name of database
    String path = '$directory/recipes.db';
    return openDatabase(
      path,
      version: 1,
      // to create the table
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $preperationTimeColumn INTEGER,'
            ' $isFavoriteColumn INTEGER, '
            '$ingredientsColumn TEXT, $instructionsColumn TEXT, $imageColumn TEXT)');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $preperationTimeColumn INTEGER,'
            ' $isFavoriteColumn INTEGER, '
            '$ingredientsColumn TEXT, $instructionsColumn TEXT, $imageColumn TEXT)');
      },
      onDowngrade: (db, oldVersion, newVersion) {
        db.delete(tableName);
      },
    );
  }

  // To Read data
  Future<List<RecipeModel>> getAllRecipes() async {
    List<Map<String, dynamic>> tasks = await database.query(tableName);
    return tasks.map((e) => RecipeModel.fromMap(e)).toList();
  }

  // To Insert some data
  insertNewRecipe(RecipeModel recipeModel) {
    database.insert(tableName, recipeModel.toMap());
  }

  // To Delete one column from table
  deleteRecipe(RecipeModel recipeModel) {
    database
        .delete(tableName, where: '$idColumn=?', whereArgs: [recipeModel.id]);
  }

  // To Delete all of table
  deleteRecipes() {
    database.delete(tableName);
  }

  // To update data
  updateRecepi(RecipeModel recipeModel) async {
    await database.update(
        tableName,
        {
          isFavoriteColumn: recipeModel.isFavorite ? 1 : 0,
          nameColumn: recipeModel.name,
          preperationTimeColumn: recipeModel.preperationTime,
          imageColumn: recipeModel.image!.path,
          ingredientsColumn: recipeModel.ingredients,
          instructionsColumn: recipeModel.instructions
        },
        where: '$idColumn=?',
        whereArgs: [recipeModel.id]);
  }

  updateIsFavorite(RecipeModel recipeModel) {
    database.update(
        tableName, {isFavoriteColumn: !recipeModel.isFavorite ? 1 : 0},
        where: '$idColumn=?', whereArgs: [recipeModel.id]);
  }
}
