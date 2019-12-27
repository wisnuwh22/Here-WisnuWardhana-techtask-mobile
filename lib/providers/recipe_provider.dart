import 'package:tech_task/models/recipe_model.dart';
import 'package:tech_task/repositories/recipe_repository.dart';
import 'base_provider.dart';

class RecipeProvider extends BaseProvider {

final _recipeRepository = RecipeRepository();

  // setter and getter for list recipes
  List <RecipeModel> _recipes = [];
  List <RecipeModel> get listRecipe => _recipes;
  set listRecipe (List<RecipeModel> recipes) {
    _recipes.clear();
    _recipes.addAll(recipes);
    
  }

  // fetch recipe data from repository
  Future<void> fetchRecipe () async {
    setBusy();
    listRecipe = await _recipeRepository.fetchRecipe();

    setIdle();
    notifyListeners();
  }
}