import 'package:tech_task/domain/abstracts/recipe_cache.dart';
import 'package:tech_task/domain/abstracts/recipe_source.dart';
import 'package:tech_task/domain/models/recipe_model.dart';
import 'package:tech_task/infrastructure/api/recipe_api_source.dart';
import 'package:tech_task/infrastructure/db/recipe_db_source.dart';

// Recipe Repository is class that handling
// supply data for Recipe
// currently Recipe data is not being cached yet
class RecipeRepository {

  // List of different data sources
  List<RecipeSource> sources = <RecipeSource>[
    RecipeApiSource(),
    RecipeDbSource()
  ];

  List<RecipeCache> caches = <RecipeCache>[
    RecipeDbSource(),
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
      if(recipes != null && recipes.length > 0) {
        break;
      }
    }

    // looping through all data caches
    // if data caches is not same with latest data source,
    // add recipe to data caches
    for(var cache in caches) {
      if(cache != source) {
        cache.addRecipes(recipes);
      }
    } 

    return recipes;
  }

  
}