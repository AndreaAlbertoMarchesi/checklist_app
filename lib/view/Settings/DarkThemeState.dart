import 'package:checklist_app/view/Settings/SharedPreferences.dart';
import 'package:flutter/material.dart';

class DarkThemeState with ChangeNotifier {

  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool darkTheme = false;

  getDarkTheme() async{
    darkTheme = await darkThemePreference.getTheme();
    notifyListeners();
  }

  setDarkTheme(bool value) {
    darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}