class RecipeModel {
  final String title;
  final List<String> ingredients;

  RecipeModel({this.title, this.ingredients});
  RecipeModel.fromJson(Map<String, dynamic> parsedJson)
    :title = parsedJson["title"],
    ingredients = new List<String>.from(parsedJson["ingredients"]);
  
}

// Recipe Model for database purpose
class RecipeDbModel {
  final String title;
  final String ingredient;

  RecipeDbModel({this.title, this.ingredient});
  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "recipe": title,
      "ingredient": ingredient,
    };
  }

  RecipeDbModel.fromJson(Map<String, dynamic> parsedJson)
    :title = parsedJson["recipe"],
    ingredient = parsedJson["ingredient"];
}