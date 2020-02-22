import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

dynamic getPref(Type type, {String pref = ""}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (type == Key) return prefs.getKeys();
  if (pref == "") throw ArgumentError("No preference name provided.");
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

final SlideTransition Function(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child)
    pageTransition = (
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  Offset begin = Offset(0, 1);
  Offset end = Offset.zero;
  Animatable<Offset> tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.decelerate));

  Animation<Offset> offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
};

final SlideTransition Function(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child)
    fileSelectTransition = (
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  Offset begin = Offset(0, 1);
  Offset end = Offset(0, 0.8);
  Animatable<Offset> tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.decelerate));

  Animation<Offset> offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
};

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);
final Color darkBlueAccent = Color.fromARGB(255, 65,	77, 89);
