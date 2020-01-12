import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future<String> getLunchDate() async 
{
  final SharedPreferences prefs = await _prefs;
  return prefs.getString(lunchDatePreference) ?? false;
}

Future<bool> setLunchDate(String value) async
{
  final SharedPreferences prefs = await _prefs;
  return prefs.setString(lunchDatePreference, value);
}