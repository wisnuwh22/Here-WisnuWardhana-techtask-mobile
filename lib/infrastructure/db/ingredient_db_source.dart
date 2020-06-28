import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:tech_task/domain/abstracts/ingredient_cache.dart';
import 'package:tech_task/domain/abstracts/ingredient_source.dart';
import 'package:tech_task/domain/models/ingredient_model.dart';

import 'lunch_db.dart';

// Ingredient db source works both as data Source and data Cache
// The primary data source for Ingredient is API
// if the API working properly, data from API will be stored here as cache
// if the API doesn't work, data will be loaded from this db source
class IngredientDbSource implements IngredientSource, IngredientCache {
 static LunchDb _lunchDb;
  static IngredientDbSource _ingredientDbSource;

  IngredientDbSource._createObject();

  factory IngredientDbSource(){
    _lunchDb = LunchDb();
    if (_ingredientDbSource == null){
      _ingredientDbSource = IngredientDbSource._createObject();
    }
    return _ingredientDbSource;
  }

  // Initialize lunch db with Ingredient Table
  // Future<Database> initDb() async {
  //   Directory documentDirectory = await getApplicationDocumentsDirectory();
  //   final path = join(documentDirectory.path, "lunch.db");
  //   Database db = await openDatabase(
  //     path,
  //     version: 1,
  //     onCreate: (Database newDB, int version) {
  //       newDB.execute("""
  //         CREATE TABLE Ingredients 
  //         (
  //           title TEXT PRIMARY KEY,
  //           useBy TEXT
  //         )
  //       """);
  //     }
  //   );

  //   return db;
  // }


  // fetching Ingredient from Ingredient table in lunch db
  @override
  Future<List<IngredientModel>> fetchIngredients() async{

    // Database db = await this.database;
    // final ingredientMaps = await db.query(
    //   "Ingredients",
    //   columns: null,
    // );
    final ingredientMaps = await _lunchDb.selectIngredient();
    List<IngredientModel> ingredientModels = List();
    ingredientMaps.forEach((map) =>ingredientModels.add(IngredientModel.fromDb(map)));
    return ingredientModels;
  }

  // cache data to lunch db
  // by adding all Ingredient to Ingredient table in lunch db
  @override
  addIngredients(List<IngredientModel> ingredients) {
    clear();
    ingredients.forEach((ingredient) => _lunchDb.insertIngredient(ingredient));
  }

  // Future<int> insert(IngredientModel ingredient) async {
  //   Database db = await this.database;
  //   int count = await db.insert('Ingredients', ingredient.toMap());
  //   return count;
  // }

  // Future<Database> get database async {
  //   if (_db == null) {
  //     _db = await initDb();
  //   }
  //   return _db;
  // }

  // Future<List<Map<String, dynamic>>> select() async {
  //   Database db = await this.database;
  //   var mapList = await db.query('Ingredients');
  //   return mapList;
  // }

  // Future<int> delete() async {
  //   Database db = await this.database;
  //   int count = await db.delete('Ingredients', 
  //                               where: null);
  //   return count;
  // }

  // clear database
  @override
  clear() {
    //_db.delete("Ingredients");
    _lunchDb.deleteIngredient();
  }
  
}

//final ingredientDbSource = IngredientDbSource();