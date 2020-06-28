import 'package:intl/intl.dart';
import 'package:tech_task/domain/settings/constants.dart';

class IngredientModel {
  final String title;
  final DateTime useBy;

  IngredientModel({this.title, this.useBy});

  IngredientModel.fromJson(Map<String, dynamic> parsedJson)
    : title = parsedJson["title"],
      useBy = DateTime.parse(parsedJson["use-by"]);

  IngredientModel.fromDb(Map<String, dynamic> parsedJson) 
    : title = parsedJson["title"],
      useBy = DateTime.parse(parsedJson["useBy"]);

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "title": title,
      "useBy": DateFormat(DATE_TIME_FORMAT).format(useBy),
    };
  }
}