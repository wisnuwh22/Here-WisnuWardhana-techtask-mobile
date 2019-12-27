import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task/providers/ingredient_provider.dart';
import 'package:tech_task/providers/recipe_provider.dart';
import 'package:tech_task/settings/colors.dart';
import 'package:tech_task/widgets/loading_display.dart';
import 'package:tech_task/widgets/nodata_display.dart';

class RecipePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecipeState();
  }
}

class _RecipeState extends State<RecipePage> {

  RecipeProvider _provider;
  @override
  Widget build(BuildContext context) {

    _provider = Provider.of<RecipeProvider>(context, listen: false);
    _provider.fetchRecipe();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Lunch Receipes'),
      ),
      body: _buildRecipeList(),
    );
  }

  // List View Widget to show recipe and its ingredients
  Widget _buildRecipeList() {
    
    return Consumer<RecipeProvider>(
      builder: (context, _recipeProvider,_){

        var _recipes = _recipeProvider.listRecipe;
        var _isLoading = _recipeProvider.isLoading;

        if(_isLoading) {
          return loadingDisplay();
        }
        else {
          if(_recipes.length > 0) {
            return ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index) {

                var _recipe = _recipes[index];

                return ListTile(
                    title: Text('${_recipe.title}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Ingredients: '),
                        _buildIngredientList(_recipe.ingredients),
                      ],
                  ),
                );
              }
            );
          }
          else {
            return nodataDisplay();
          }
        }
        
      }
    );
  }
 
  // child widget of recipe list to show ingredients
  Widget _buildIngredientList(List<String> ingredients){
    var _ingredientProvider = Provider.of<IngredientProvider>(context, listen: false);
    var _listCheckedIngredient = _ingredientProvider.listIngredient.where((ing) => ing.isChecked).toList();
    var _listStringIngredient = _listCheckedIngredient.map((ing) => ing.toString());
    return Wrap(
      children: ingredients.map((ing) => 
          Chip(label: Text(ing), 
               backgroundColor: _listStringIngredient.contains(ing)? primaryColor : secondaryColor))
          .toList(),
    );
  }

}

