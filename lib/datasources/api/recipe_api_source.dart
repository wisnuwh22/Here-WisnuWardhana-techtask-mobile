import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:tech_task/abstracts/recipe_source.dart';
import 'package:tech_task/models/recipe_model.dart';
import 'package:tech_task/settings/constants.dart';

// Recipe API Sourse is the primary data source for Recipe
class RecipeApiSource implements RecipeSource{

  Client client = Client();
  // fetching Recipe data from API
  @override
  Future<List<RecipeModel>> fetchRecipes() async {

    try {
    
      final response = await client.get('$RECIPE_URL?ingredients=Ham,Cheese');
      final recipes = json.decode(response.body) as List;
    
      return recipes.map((i) => RecipeModel.fromJson(i)).toList();
    }
    catch (Exceptiom) {
      return null;
    }
  }
}