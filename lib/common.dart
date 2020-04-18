import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension PrecisionRounding on double {
  double roundToPlaces(int places) {
    double mod = Math.pow(10.0, places);
    return ((this * mod).round().toDouble() / mod);
  }
}

Future<Set<String>> getPrefKeys() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getKeys();
}

dynamic getPref(String pref, Type type) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (pref == null) throw ArgumentError("No preference name provided.");
  try {
    switch (type) {
      case bool:
        return prefs.getBool(pref);
        break;
      case int:
        return prefs.getInt(pref);
        break;
      case String:
        return prefs.getString(pref);
        break;
      case List:
        return prefs.getStringList(pref);
        break;
      case double:
        return prefs.getDouble(pref);
        break;
    }
    // ignore: unused_catch_clause
  } on AssertionError catch (err) {
    throw TypeError();
  }
}

SlideTransition pageTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  Animatable<Offset> tween = Tween(
    begin: Offset(0, 1),
    end: Offset.zero,
  ).chain(
    CurveTween(curve: Curves.ease),
  );

  Animation<Offset> offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}

SlideTransition fileSelectTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  Animatable<Offset> tween = Tween(
    begin: Offset(0, 1),
    end: Offset(0, 0.8),
  ).chain(
    CurveTween(curve: Curves.ease),
  );

  Animation<Offset> offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);
const Color darkBlueAccent = Color.fromARGB(255, 34, 58, 84);

ThemeData commonTheme() {
  return ThemeData(
    backgroundColor: darkBlue,
    accentColor: Colors.orange,
    primaryColor: darkBlue,
    fontFamily: "PTSans",
    brightness: Brightness.dark,
    // textTheme: Typography.blackMountainView,
    buttonTheme: ButtonThemeData(
      buttonColor: darkBlueAccent,
      textTheme: ButtonTextTheme.normal,
    ),
  );
}
