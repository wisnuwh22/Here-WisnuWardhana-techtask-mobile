import 'package:tech_task/domain/abstracts/recipe_cache.dart';
import 'package:tech_task/domain/abstracts/recipe_source.dart';
import 'package:tech_task/domain/models/recipe_model.dart';
import 'lunch_db.dart';

class RecipeDbSource implements RecipeSource, RecipeCache {
  static LunchDb _lunchDb;
  static RecipeDbSource _recipeDbSource;

  RecipeDbSource._createObject();


  factory RecipeDbSource(){
    _lunchDb = LunchDb();
     if (_recipeDbSource == null){
      _recipeDbSource = RecipeDbSource._createObject();
    }
    return _recipeDbSource;
  }

  // fetching Recipe from Recipe table in lunch db
  // if failed, return empty list of RecipeModel
  @override
  Future<List<RecipeModel>> fetchRecipes() async {
    List <RecipeModel> recipes = List<RecipeModel>();
    final recipedbs = await _lunchDb.selectRecipe();
    recipedbs.forEach((recipedbmap){
      var recipedb = RecipeDbModel.fromJson(recipedbmap);    
      var recipe = recipes.firstWhere((x) => x.title == recipedb.title, orElse : () => null);
      if(recipe == null) {
        recipe = RecipeModel(title: recipedb.title, ingredients: [recipedb.ingredient]);
        recipes.add(recipe);
      } else {
        recipe.ingredients.add(recipedb.ingredient);      
      }     
    });
    return recipes;
  }
  
  // cache data to lunch db
  // by adding all Recipe to Recipe table in lunch db
  @override
  addRecipes(List<RecipeModel> recipes) {
    clear();
    recipes.forEach((recipe) {
      recipe.ingredients.forEach((ingredient) => _lunchDb.insertRecipe(
          RecipeDbModel(title: recipe.title, ingredient: ingredient)
      ));
    });
  }

  // clear Recipe Table
  @override
  clear() {
    _lunchDb.deleteRecipe();
  }


}