import 'package:tech_task/domain/abstracts/ingredient_cache.dart';
import 'package:tech_task/domain/abstracts/ingredient_source.dart';
import 'package:tech_task/domain/models/ingredient_model.dart';
import 'package:tech_task/infrastructure/api/ingredient_api_source.dart';
import 'package:tech_task/infrastructure/db/ingredient_db_source.dart';

// Ingredient repository is class that handling
// supply data for Ingredient
// whether its from sources or caches


class IngredientRepository {

  // List of Ingredient data sources
  // Currently only from API and local Database
  List<IngredientSource> sources = <IngredientSource>[
    IngredientApiSource(),
    ingredientDbSource,
  ];

  // List of Ingredient data caches
  // Currently in local database
  List<IngredientCache> caches = <IngredientCache>[
    ingredientDbSource,
  ];

  // fetching ingredients from all data sources
  // then add it all to caches
  // and then return ingredients 
  Future<List<IngredientModel>> fetchIngredients() async {
    List<IngredientModel> ingredients;
    var source;

    // looping through all data sources
    // if data not null, break the looping
    // if data null, continue looping to fetch next data source
    for(source in sources) {
      ingredients = await source.fetchIngredients();
      if(ingredients != null && ingredients.length > 0) {
        break;
      }
    }

    // looping through all data caches
    // if data caches is not same with latest data source,
    // add ingredient to data caches
    for(var cache in caches) {
      if(cache != source) {
        cache.addIngredients(ingredients);
      }
    } 
    return ingredients;
  }

  // clear all data in all caches
  clearCache() async{
    for(var cache in caches) {
      await cache.clear();
    }
  }
}