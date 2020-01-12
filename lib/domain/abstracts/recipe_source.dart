import 'package:tech_task/domain/models/recipe_model.dart';

// abstract class for Recipe Data sources
// all Recipe data source classes must implement this class
abstract class RecipeSource {
  Future<List<RecipeModel>> fetchRecipes();
}