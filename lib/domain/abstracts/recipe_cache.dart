import 'package:tech_task/domain/models/recipe_model.dart';

abstract class RecipeCache {
  addRecipes(List<RecipeModel> recipes);
  clear();
}