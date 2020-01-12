import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:tech_task/domain/abstracts/ingredient_cache.dart';
import 'package:tech_task/domain/abstracts/ingredient_source.dart';
import 'package:tech_task/domain/models/ingredient_model.dart';

// Ingredient db source works both as data Source and data Cache
// The primary data source for Ingredient is API
// if the API working properly, data from API will be stored here as cache
// if the API doesn't work, data will be loaded from this db source
class IngredientDbSource implements IngredientSource, IngredientCache {
  Database db;

  IngredientDbSource() {
    init();
  }

  // Initialize lunch db with Ingredient Table
  void init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "lunch.db");
    db = await openDatabase(
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
      }
    );
  }


  // fetching Ingredient from Ingredient table in lunch db
  @override
  Future<List<IngredientModel>> fetchIngredients() async{
    final ingredientMaps = await db.query(
      "Ingredients",
      columns: null,
    );

    List<IngredientModel> ingredientModels = List();
    ingredientMaps.forEach((map) =>ingredientModels.add(IngredientModel(title: map["title"], useBy: map["useBy"])));
    return ingredientModels;
  }

  // cache data to lunch db
  // by adding all Ingredient to Ingredient table in lunch db
  @override
  addIngredients(List<IngredientModel> ingredients) {
    clear();
    ingredients.forEach((ingredient){
      db.insert(
      "Ingredients", 
      ingredient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore
    );
    });
    
  }

  // clear database
  @override
  clear() {
    db.delete("Ingredients");
  }
  
}

final ingredientDbSource = IngredientDbSource();