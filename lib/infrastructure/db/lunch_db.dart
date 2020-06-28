import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tech_task/domain/models/ingredient_model.dart';
import 'package:tech_task/domain/models/recipe_model.dart';

class LunchDb {
  static Database _db;

  // Initialize lunch db with Ingredient Table and Recipe Table
  static Future<Database> initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "lunch.db");
    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDB, int version) {
        newDB.execute("""
          CREATE TABLE Ingredients 
          (
            title TEXT PRIMARY KEY,
            useBy TEXT
          )
        """);
        newDB.execute("""
          CREATE TABLE Recipes 
          (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            recipe TEXT,
            ingredient TEXT
          )
        """);
      }
    );

    return db;
  }

  // Get Database
  static Future<Database> get lunchDatabase async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }


  // ======= Methods for Ingredient Table ==============

  Future<int> insertIngredient(IngredientModel ingredient) async {
    Database db = await lunchDatabase;
    int count = await db.insert('Ingredients', ingredient.toMap());
    return count;
  }

  Future<List<Map<String, dynamic>>> selectIngredient() async {
    Database db = await lunchDatabase;
    var mapList = await db.query('Ingredients');
    return mapList;
  }

  Future<int> deleteIngredient() async {
    Database db = await lunchDatabase;
    int count = await db.delete('Ingredients');
    return count;
  }

  // ======= Methods for Ingredient Table ==============

  Future<int> insertRecipe(RecipeDbModel recipe) async {
    Database db = await lunchDatabase;
    int count = await db.insert('Recipes', recipe.toMap());
    return count;
  }

  Future<List<Map<String, dynamic>>> selectRecipe() async {
    Database db = await lunchDatabase;
    var mapList = await db.query('Recipes');
    return mapList;
  }

  Future<int> deleteRecipe() async {
    Database db = await lunchDatabase;
    int count = await db.delete('Recipes');
    return count;
  }

}