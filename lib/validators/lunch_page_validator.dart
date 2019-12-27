import 'package:tech_task/settings/messages.dart';

class LunchPageValidator {

  // check if user input a valid date
  // if valid, return null
  // if not valid, return error message
  static String validateLunchDate(String val) {
    DateTime lunchDate = DateTime.tryParse(val);
    return lunchDate == null ? invalidLunchDateMessage : null;
  }
}