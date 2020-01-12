import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:tech_task/abstracts/ingredient_source.dart';
import 'package:tech_task/models/ingredient_model.dart';
import 'package:tech_task/settings/constants.dart';

// Ingredient API Source is the primary data source for Ingredient
class IngredientApiSource implements IngredientSource{
  
  Client client = Client();
  // fetching Ingredient data from API
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