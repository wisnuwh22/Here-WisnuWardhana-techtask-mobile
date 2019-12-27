import 'package:tech_task/models/ingredient_model.dart';

// abstract class for Ingredient data caches
// all Ingredient data caches classes must implement this class
abstract class IngredientCache {
  addIngredients(List<IngredientModel> ingredients);
  clear();
}