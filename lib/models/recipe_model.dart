class RecipeModel {
  final String title;
  final List<String> ingredients;

  RecipeModel({this.title, this.ingredients});
  RecipeModel.fromJson(Map<String, dynamic> parsedJson)
    :title = parsedJson["title"],
    ingredients = new List<String>.from(parsedJson["ingredients"]);
  
}