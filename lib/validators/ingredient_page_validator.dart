import 'package:tech_task/settings/messages.dart';
import 'package:tech_task/viewmodels/ingredient_view_model.dart';

class IngredientPageValidator {

  // check if any ingredient is selected
  // if found, return null
  // if not found, return error message
  static String validateIngredient(List<IngredientViewModel> val) {
    int checked = val.where((ing) => ing.isChecked).toList().length;
    return checked > 0 ? null : noIngredientSelectedMessage;
  }
}