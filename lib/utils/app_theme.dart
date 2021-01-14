import 'package:flutter/material.dart';

class AppTheme {
  // static var headLine1;
  // static var headLine96px;
  // static var headLine60px;
  // static var headLine48px;
  // static var headLine34px;
  // static var headLine20px;
  // static var subtitle16px;
  // static var subtitle14px;
  // static var bodyText16px;
  // static var bodyText14px;
  // static var caption12px;
  // static var overline10px;
  // void theme(BuildContext context) {
  //   headLine1 = Theme.of(context).textTheme.headline1;
  //   headLine96px = Theme.of(context).textTheme.headline2;
  //   headLine60px = Theme.of(context).textTheme.headline3;
  //   headLine48px = Theme.of(context).textTheme.headline4;
  //   headLine34px = Theme.of(context).textTheme.headline5;
  //   headLine20px = Theme.of(context).textTheme.headline6;
  //   subtitle16px = Theme.of(context).textTheme.subtitle1;
  //   subtitle14px = Theme.of(context).textTheme.subtitle2;
  //   bodyText16px = Theme.of(context).textTheme.bodyText1;
  //   bodyText14px = Theme.of(context).textTheme.bodyText2;
  //   caption12px = Theme.of(context).textTheme.caption;
  //   overline10px = Theme.of(context).textTheme.overline;
  // }

  static final Color appBackgroundColorDark = Color(0xFF212121);
  static final Color appBackgroundColorLight = Color(0xFFFCFCFC);
  static final IconThemeData _primaryIconTheme =
      IconThemeData(color: Colors.pinkAccent);

  static final ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: appBackgroundColorLight,
    primaryColor: Colors.white,
    unselectedWidgetColor: Colors.white,
    textTheme: _textThemeLight,
    primaryTextTheme: _textThemeLight,
    accentColor: Colors.pinkAccent,
    primaryIconTheme: _primaryIconTheme,
    cardColor: Colors.white,
  );
  static final ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: appBackgroundColorDark,
    primaryColor: Colors.black,
    unselectedWidgetColor: Colors.white,
    textTheme: _textThemeDark,
    accentColor: Colors.pinkAccent,
    primaryTextTheme: _textThemeDark,
    primaryIconTheme: _primaryIconTheme,
    cardColor: Colors.grey[900],
  );

  static final TextTheme _textThemeLight = TextTheme(
    bodyText1: TextStyle(color: Colors.black),
    bodyText2: TextStyle(color: Colors.black),
    subtitle1: TextStyle(color: Colors.black),
  );
  static final TextTheme _textThemeDark = TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white),
    subtitle1: TextStyle(color: Colors.white),
    button: _buttonDark,
  );

  //Light Mode Text theme
  static final TextStyle _titleLight = TextStyle(
    color: Colors.black,
  );
  static final TextStyle _subtitle1Light = TextStyle(
    color: Color(0xFFD16AB7),
  );
  static final TextStyle _subHeadLight = TextStyle(
    color: Color(0xFFD16AB7),
  );
  static final TextStyle _buttonLight = TextStyle(
    color: Colors.black,
  );

// Dark Mode Text theme

  static final TextStyle _titleDark = _titleLight.copyWith(color: Colors.white);
  static final TextStyle _subtitleDark =
      _titleLight.copyWith(color: Colors.white);
  static final TextStyle _buttonDark =
      _titleLight.copyWith(color: Colors.white);
}
