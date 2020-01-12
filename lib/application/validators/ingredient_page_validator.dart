import 'package:tech_task/application/viewmodels/ingredient_view_model.dart';
import 'package:tech_task/domain/settings/messages.dart';

class IngredientPageValidator {

  // check if any ingredient is selected
  // if found, return null
  // if not found, return error message
  static String validateIngredient(List<IngredientViewModel> val) {
    int checked = val.where((ing) => ing.isChecked).toList().length;
    return checked > 0 ? null : NO_DATA_SELECTED_MESSAGE;
  }
}