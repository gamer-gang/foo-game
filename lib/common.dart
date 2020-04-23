import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension PrecisionRounding on double {
  /// Returns a new double rounded to a certain number of digits.
  double roundTo(int places) {
    double mod = Math.pow(10.0, places);
    return ((this * mod).round().toDouble() / mod);
  }
}

extension OffsetUtil on Offset {
  /// Returns a modified offset with the provided `x`.
  Offset withX(double x) => Offset(x, this.dy);

  /// Returns a modified offset with the provided `y`.
  Offset withY(double y) => Offset(this.dx, y);

  /// Scale only the `x` of the offset.
  Offset scaleX(double x) => Offset(this.dx * x, this.dy);

  /// Scale only the `y` of the offset.
  Offset scaleY(double y) => Offset(this.dx, this.dy * y);

  /// Translate only the `x` of the offset.
  Offset translateX(double x) => Offset(this.dx + x, this.dy);

  /// Translate only the `y` of the offset.
  Offset translateY(double y) => Offset(this.dx, this.dy + y);

  /// Returns a new offset scaled by the argument.
  Offset scaleBy(Offset scale) =>
      Offset(this.dx * scale.dx, this.dy * scale.dy);

  /// Limit the offset to the given bounds.
  Offset limit(Offset max) => Offset(
        this.dx > max.dx ? max.dx : this.dx,
        this.dy > max.dy ? max.dx : this.dy,
      );

  /// Limit the `x` component.
  Offset limitX(double max) => Offset(
        this.dx > max ? max : this.dx,
        this.dy,
      );

  /// Generate a random offset, where each component is a random double in (-1.0, 1.0), exclusive.
  static Offset random() {
    Math.Random r = Math.Random();
    return Offset(
      r.nextBool() ? r.nextDouble() : -r.nextDouble(),
      r.nextBool() ? r.nextDouble() : -r.nextDouble(),
    );
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
