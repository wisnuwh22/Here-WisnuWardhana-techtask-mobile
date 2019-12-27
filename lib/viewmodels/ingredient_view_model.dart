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
  bool isPassedUseBy;
  bool isChecked;

  IngredientViewModel(IngredientModel ingredientModel, DateTime lunchDate) {
    title = ingredientModel.title;
    useBy = DateFormat(dateTimeFormat).format(ingredientModel.useBy);
    int days = ingredientModel.useBy.compareTo(lunchDate);
    isPassedUseBy = days.isNegative ? true : false;
    isChecked = false;
  }

 
  // toggle isChecked value
  // can not update isChecked if already passed use-by
  toggled() {
    if(!isPassedUseBy)
      isChecked = !isChecked;
  }

  @override
  String toString() {
    return title;
  }
}