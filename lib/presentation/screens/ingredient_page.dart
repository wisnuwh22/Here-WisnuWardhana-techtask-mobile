import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task/application/providers/ingredient_provider.dart';
import 'package:tech_task/application/validators/ingredient_page_validator.dart';
import 'package:tech_task/domain/settings/colors.dart';
import 'package:tech_task/domain/settings/constants.dart';
import 'package:tech_task/presentation/widgets/loading_display.dart';
import 'package:tech_task/presentation/widgets/nodata_display.dart';
import 'package:tech_task/presentation/widgets/warning_dialog.dart';

class IngredientPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _IngredientState();
  }
}

class _IngredientState extends State<IngredientPage> {

  IngredientProvider ingredientProvider;

  @override
  Widget build(BuildContext context) {

    ingredientProvider = Provider.of<IngredientProvider>(context, listen: false);
    ingredientProvider.fetchIngredient();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lunch Ingredients'),
      ),
      body: _buildList(),
      floatingActionButton: _buildFloatingButton(),
    );

  }

  // floating button widget to go next page
  // if no ingredient selected, display error message
  // if any ingredient selected, go to next page
  Widget _buildFloatingButton() {
    return FloatingActionButton(
      onPressed: (){
        String err = IngredientPageValidator.validateIngredient(ingredientProvider.listIngredient);
        if(err ==  null)
          Navigator.pushNamed(context, RECIPE_PAGE_ROUTE);
        else
          WarningDialog.getInstance().showWarningDialog(context, err);
      },
      child: Icon(Icons.next_week),
    );
  }

  // widget to build list ingredients
  Widget _buildList() {

    return Consumer<IngredientProvider>(
      builder: (context, ingredientProvider, _){

        var _ingredients = ingredientProvider.listIngredient;
        var _isLoading = ingredientProvider.isLoading;

        if(_isLoading) {
          return loadingDisplay();
        }
        else {
          if(_ingredients.length > 0) {
            return ListView.builder(
              itemCount: _ingredients.length,
              itemBuilder: (context, index) {
            
                var _ingredient = _ingredients[index];
            
                return CheckboxListTile(
                  title: Text('${_ingredient.title}'),
                  subtitle: Text('use-by : ${_ingredient.useBy}', 
                    style: TextStyle(color: !_ingredient.isPastUseBy? PRIMARY_COLOR : SECONDARY_COLOR)),
                  value: _ingredient.isChecked,
                  onChanged: (bool value) => 
                    ingredientProvider.toggleIngredient(_ingredient)
                );
              }
            ); 
          }
          else {
            return nodataDisplay();
          }
        }
        
        
        
      },
    ); 
    
  }

}

