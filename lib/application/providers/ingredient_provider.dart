import 'package:tech_task/application/providers/base_provider.dart';
import 'package:tech_task/application/viewmodels/ingredient_view_model.dart';
import 'package:tech_task/domain/models/ingredient_model.dart';
import 'package:tech_task/domain/repositories/ingredient_repository.dart';
import 'package:tech_task/domain/settings/preference.dart';

class IngredientProvider extends BaseProvider {

  final _ingredientRepository = IngredientRepository();

  // setter getter for list ingredients
  List <IngredientViewModel> _ingredients = [];
  List <IngredientViewModel> get listIngredient => _ingredients;
  set listIngredientViewModel (List<IngredientModel> ingredients) {
    _ingredients.clear();
    _ingredients = ingredients.map((ing) => IngredientViewModel(ing, lunchDate)).toList();
  }

  DateTime lunchDate;

  // toggle the choosen ingredient
  void toggleIngredient(IngredientViewModel ingredient) {
    final _index = _ingredients.indexOf(ingredient);
    _ingredients[_index].toggled();
    notifyListeners();
  }

  // get lunch date from shared preference
  // and then fetch ingredient data from repository
  Future<void> fetchIngredient () async {
    setBusy();

    String lunchDateString = await getLunchDate(); 
    lunchDate = DateTime.tryParse(lunchDateString) ?? DateTime.now();
    
    if(_ingredients.length == 0)
      listIngredientViewModel = await _ingredientRepository.fetchIngredients();
    
    setIdle();
    notifyListeners();
  }
}