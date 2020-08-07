import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:tech_task/domain/abstracts/recipe_source.dart';
import 'package:tech_task/domain/models/recipe_model.dart';
import 'package:tech_task/domain/settings/constants.dart';

// Recipe API Source is the primary data source for Recipe
class RecipeApiSource implements RecipeSource{

  Client client = Client();
  
  // fetching Recipe from API
  // If failed, return empty list of RecipeModel
  @override
  Future<List<RecipeModel>> fetchRecipes() async {

    try {
    
      final response = await client.get('$RECIPE_URL?ingredients=Ham,Cheese');
      final recipes = json.decode(response.body) as List;
    
      return recipes.map((i) => RecipeModel.fromJson(i)).toList();
    }
    catch (Exceptiom) {
      return List<RecipeModel>();
    }
  }
}