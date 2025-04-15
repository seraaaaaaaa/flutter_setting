import 'package:flutter/material.dart';
import 'package:flutter_setting/enum/font_size.dart';
import 'package:flutter_setting/enum/language.dart';

class SettingProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  Color _primaryColor = Colors.blue;
  Color get primaryColor => _primaryColor;

  FontSize _fontSize = FontSize.medium;
  FontSize get fontSize => _fontSize;

  Language _language = Language.english;
  Language get language => _language;
  Locale get locale => _language.toLocale;

  void toggleTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  void setPrimaryColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }

  void setFontSize(FontSize sizeOption) {
    _fontSize = sizeOption;
    notifyListeners();
  }

  void setLanguage(Language newLang) {
    _language = newLang;
    notifyListeners();
  }

  MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }
}
