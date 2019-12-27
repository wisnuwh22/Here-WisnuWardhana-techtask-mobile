import 'package:intl/intl.dart';
import 'package:tech_task/models/ingredient_model.dart';
import 'package:tech_task/settings/constants.dart';

// View Model for Ingredient
// Handling User Interaction for single Ingredient
// additional variables :
// bool isPassedUseBy : work as indicator wheter Ingredient use-by already pass lunch data
// bool isChecked : work as indicator wheter Ingredient is choosen by user
class IngredientViewModel {
  String title;
  String useBy;
  bool isPastUseBy;
  bool isChecked;

  IngredientViewModel(IngredientModel ingredientModel, DateTime lunchDate) {
    title = ingredientModel.title;
    useBy = DateFormat(dateTimeFormat).format(ingredientModel.useBy);
    int days = ingredientModel.useBy.compareTo(lunchDate);
    isPastUseBy = days.isNegative ? true : false;
    isChecked = false;
  }

 
  // toggle isChecked value
  // can not update isChecked if already past use-by
  toggled() {
    if(!isPastUseBy)
      isChecked = !isChecked;
  }

  @override
  String toString() {
    return title;
  }
}