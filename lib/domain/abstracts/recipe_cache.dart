import 'package:tech_task/domain/models/recipe_model.dart';

// abstract class for Recipe data caches
// all Recipe data caches classes must implement this class
abstract class RecipeCache {
  addRecipes(List<RecipeModel> recipes);
  clear();
}