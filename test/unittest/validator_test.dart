import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/models/ingredient_model.dart';
import 'package:tech_task/settings/messages.dart';
import 'package:tech_task/validators/ingredient_page_validator.dart';
import 'package:tech_task/validators/lunch_page_validator.dart';
import 'package:tech_task/viewmodels/ingredient_view_model.dart';

void main() {

  group("Testing Lunch Page Validator", () {

    test("invalid datetime return error string", (){
      String mockLunchDate = "1234";
      var result = LunchPageValidator.validateLunchDate(mockLunchDate);
      expect(result, INVALID_DATE_MESSAGE);
    });

    test("valid datetime return null", (){
      String mockLunchDate = "2020-01-01";
      var result = LunchPageValidator.validateLunchDate(mockLunchDate);
      expect(result, null);
    });
  });


  group("Testing Ingredient Page Validator", () {

    test("Empty ListIngredient return error string", () {
      List<IngredientViewModel> mockIngredients = [];
      var result = IngredientPageValidator.validateIngredient(mockIngredients);
      expect(result, NO_DATA_SELECTED_MESSAGE);
    });
    test("ListIngredient with no ingredient checked return error string", () {
      var ingredientModel = IngredientModel(title: "Ham", useBy: DateTime.parse("2020-12-31"));
      var ingredientViewModel = IngredientViewModel(ingredientModel, DateTime.now());
      List<IngredientViewModel> mockIngredients = [];
      mockIngredients.add(ingredientViewModel);

      var result = IngredientPageValidator.validateIngredient(mockIngredients);
      expect(result, NO_DATA_SELECTED_MESSAGE);
    });

    test("ListIngredient with ingredient checked return null", () {
      var ingredientModel = IngredientModel(title: "Ham", useBy: DateTime.parse("2020-12-31"));
      var ingredientViewModel = IngredientViewModel(ingredientModel, DateTime.now());
      List<IngredientViewModel> mockIngredients = [];
      ingredientViewModel.toggled();
      mockIngredients.add(ingredientViewModel);

      var result = IngredientPageValidator.validateIngredient(mockIngredients);
      expect(result, null);
    });
  });
}