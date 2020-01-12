import 'package:tech_task/application/providers/base_provider.dart';
import 'package:tech_task/domain/models/recipe_model.dart';
import 'package:tech_task/domain/repositories/recipe_repository.dart';

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