import 'package:tech_task/abstracts/recipe_source.dart';
import 'package:tech_task/datasources/api/recipe_api_source.dart';
import 'package:tech_task/models/recipe_model.dart';

// Recipe Repository is class that handling
// supply data for Recipe
// currently Recipe data is not being cached yet
class RecipeRepository {

  // List of different data sources
  // Currently only from API
  List<RecipeSource> sources = <RecipeSource>[
    RecipeApiSource(),
  ];

  // fetching recipes from all data sources
  Future<List<RecipeModel>> fetchRecipe() async {

    List<RecipeModel> recipes;
    var source;

    // looping through all data sources
    // if data not null, break the looping
    // if data null, continue loop to next data source
    for(source in sources) {
      recipes = await source.fetchRecipes();
      if(recipes != null) {
        break;
      }
    }

    // TODO: add recipe data cache

    return recipes;
  }

  
}