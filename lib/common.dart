import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Rounding doubles to x places.
extension PrecisionRounding on double {
  /// Returns a new double rounded to a certain number of digits.
  double roundTo(int places) {
    double mod = math.pow(10.0, places);
    return ((this * mod).round().toDouble() / mod);
  }
}

extension OffsetUtil on Offset {
  /// Returns a modified offset with the provided `x`.
  Offset withX(double x) => Offset(x, dy);

  /// Returns a modified offset with the provided `y`.
  Offset withY(double y) => Offset(dx, y);

  /// Scale only the `x` of the offset.
  Offset scaleX(double x) => Offset(dx * x, dy);

  /// Scale only the `y` of the offset.
  Offset scaleY(double y) => Offset(dx, dy * y);

  /// Translate only the `x` of the offset.
  Offset translateX(double x) => Offset(dx + x, dy);

  /// Translate only the `y` of the offset.
  Offset translateY(double y) => Offset(dx, dy + y);

  /// Returns a new offset scaled by the argument.
  Offset scaleBy(Offset scale) => Offset(dx * scale.dx, dy * scale.dy);

  /// Limit the offset to the given bounds.
  Offset limit(Offset max) => Offset(
        dx > max.dx ? max.dx : dx,
        dy > max.dy ? max.dx : dy,
      );

  /// Limit the `x` component.
  Offset limitX(double max) => Offset(dx > max ? max : dx, dy);

  /// Generate a random offset, where each component is a
  /// random double in (-1.0, 1.0), exclusive.
  static Offset random() {
    var r = math.Random();
    return Offset(
      r.nextBool() ? r.nextDouble() : -r.nextDouble(),
      r.nextBool() ? r.nextDouble() : -r.nextDouble(),
    );
  }
}

extension ColorBrightness on Color {
  Color withBrightness(double scale) {
    return Color.fromARGB(
      alpha,
      (red * scale).round(),
      (green * scale).round(),
      (blue * scale).round(),
    );
  }
}

/// Retrieve all keys using `prefs.getKeys()`.
Future<Set<String>> getPrefKeys() async {
  var prefs = await SharedPreferences.getInstance();

  return prefs.getKeys();
}

/// Retrieve a single value given a type.
dynamic getPref(String pref, Type type) async {
  var prefs = await SharedPreferences.getInstance();
  if (pref == null) throw ArgumentError("No preference name provided.");

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
}

/// JS-style event dispatching.
class EventTarget {
  Map<String, List<void Function(Map<String, dynamic>)>> listeners = {};

  EventTarget();

  void on(String type, void Function(Map<String, dynamic>) callback) {
    if (!(listeners.containsKey(type))) {
      listeners[type] = [];
    }
    listeners[type].add(callback);
  }

  void cancel(
    String type,
    void Function(String, Map<String, dynamic>) callback,
  ) {
    if (!(listeners.containsKey(type))) return;

    var stack = listeners[type];
    for (var i = 0, l = stack.length; i < l; i++) {
      if (stack[i] == callback) {
        stack.removeAt(i);
        return;
      }
    }
  }

  void emit(String type, [Map<String, dynamic> data]) {
    if (!(listeners.containsKey(type))) return;

    var stack = listeners[type].sublist(0);

    for (var i = 0, l = stack.length; i < l; i++) {
      stack[i](data);
    }
  }
}

/// Default page transition for this app.
SlideTransition pageTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  var tween = Tween(
    begin: Offset(0, 1),
    end: Offset.zero,
  ).chain(
    CurveTween(curve: Curves.ease),
  );

  var offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}

/// General dark blue for use in UI.
const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

/// Accent for `darkBlue`.
const Color darkBlueAccent = Color.fromARGB(255, 34, 58, 84);

/// Base theme for the app, placed in a function to allow edits on hot reload.
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

Widget loadingScreen() {
  return Container(
    color: darkBlue,
    child: Center(
      child: Column(children: <Widget>[
        Spacer(flex: 16),
        Text(
          "MONUMENT PLATFORMER",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        Spacer(),
        Text(
          "Loading...",
          style: TextStyle(fontSize: 16),
        ),
        Spacer(),
        CircularProgressIndicator(
          strokeWidth: 2,
          value: null,
        ),
        Spacer(flex: 16)
      ]),
    ),
  );
}
