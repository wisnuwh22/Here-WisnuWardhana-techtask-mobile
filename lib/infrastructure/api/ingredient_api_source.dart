import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:tech_task/domain/abstracts/ingredient_source.dart';
import 'package:tech_task/domain/models/ingredient_model.dart';
import 'package:tech_task/domain/settings/constants.dart';

// Ingredient API Source is the primary data source for Ingredient
class IngredientApiSource implements IngredientSource{
  
  Client client = Client();
  
  // fetching Ingredient from API
  // If failed, return empty list
  @override
  Future<List<IngredientModel>> fetchIngredients() async {

    try {

      final response = await client.get(INGREDIENT_URL);
      final ingredients = json.decode(response.body) as List;

      return ingredients.map((i) => IngredientModel.fromJson(i)).toList();
    
    } 
    catch(Exception) {
      return List<IngredientModel>();
    }
  }
}