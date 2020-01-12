import 'package:tech_task/domain/models/ingredient_model.dart';

// abstract class for Ingredient Data sources
// all Ingerdient data source classes must implement this class
abstract class IngredientSource {
  Future<List<IngredientModel>> fetchIngredients();
}