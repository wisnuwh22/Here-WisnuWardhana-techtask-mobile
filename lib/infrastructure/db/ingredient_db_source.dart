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

  // fetching Ingredient from Ingredient table in lunch db
  @override
  Future<List<IngredientModel>> fetchIngredients() async{

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

  // clear Ingredient Table
  @override
  clear() {
    _lunchDb.deleteIngredient();
  }
  
}
