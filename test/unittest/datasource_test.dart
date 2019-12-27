import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:tech_task/datasources/api/ingredient_api_source.dart';
import 'package:tech_task/datasources/api/recipe_api_source.dart';

void main() {

  test("fetching Ingredient from Ingredient Api Source return List Ingredient", () async {
      var ingredientApi = IngredientApiSource();

      var mockJson = [
        {'title':'Ham', 'use-by':'2020-10-31'},
        {'title':'Cheese', 'use-by':'2020-12-31'},
      ];
      
      ingredientApi.client =  MockClient((request) async {
        return Response(jsonEncode(mockJson), 200);
      });

      final result = await ingredientApi.fetchIngredients();

      expect(result.length, 2);
      expect(result[0].title, "Ham");
      expect(result[1].title, "Cheese");
  });
    

  test("fetching Recipe from Recipe Api Source return List Recipe", () async {
      var recipeApi = RecipeApiSource();

      var mockJson = [
        {'title':'Ham and Cheese Toastie', 'ingredients':['Ham', 'Cheese','Bread','Butter']},
        {'title':'Salad', 'ingredients':['Lettuce', 'Tomato','Cucumber','Beetroot', 'Salad Dressing']},
      ];
      
      recipeApi.client =  MockClient((request) async {
        return Response(jsonEncode(mockJson), 200);
      });

      final result = await recipeApi.fetchRecipes();

      expect(result.length, 2);

      expect(result[0].title, "Ham and Cheese Toastie");
      expect(result[0].ingredients.length, 4);
      expect(result[0].ingredients[0], "Ham");
      
      expect(result[1].title, "Salad");
      expect(result[1].ingredients.length, 5);
      expect(result[1].ingredients[4], "Salad Dressing");
  });




}