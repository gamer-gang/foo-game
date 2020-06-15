import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common.dart';
import 'data/store.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Map<String, String> settingsText = {
    "animations": "",
    "sendUsageData": "",
    "clear": "Yes",
  };

  @override
  void initState() {
    super.initState();
    setBooleanSettingText(["animations", "sendUsageData"]);
  }

  Future<bool> togglePref(dynamic pref) async {
    var prefs = await SharedPreferences.getInstance();
    bool next;
    // try {
    next = prefs.getBool(pref) == null ? false : !prefs.getBool(pref);
    // ignore: unused_catch_clause
    // } on AssertionError catch (_) {
    //   next = defaultValue;
    // }

    await prefs.setBool(pref, next);

    return next;
  }

  void setBooleanSettingText(dynamic val) async {
    if (val is List) {
      for (dynamic i in val) {
        var next = ((await getPref(i, bool) ?? false) ? "On" : "Off");
        setState(() {
          settingsText.update(i, (value) => next);
        });
      }
    } else {
      var next = ((await getPref(val, bool) ?? false) ? "On" : "Off");
      setState(() {
        settingsText.update(val, (value) => next);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue.withAlpha(220),
        elevation: 0,
        title: Text("Settings"),
      ),
      body: Container(
        color: Color(0xff121212),
        child: Center(
          child: Column(children: [
            Spacer(flex: 1),
            Row(children: [
              Spacer(flex: 1),
              Text("Animations"),
              Spacer(flex: 1),
              RaisedButton(
                onPressed: () {
                  togglePref("animations")
                      .then((val) => setBooleanSettingText("animations"));
                },
                child: Text(settingsText["animations"] ?? "..."),
              ),
              Spacer(flex: 20),
            ]),
            Spacer(flex: 1),
            Row(children: [
              Spacer(flex: 1),
              Text("Send anonymous usage data"),
              Spacer(flex: 1),
              RaisedButton(
                onPressed: () {
                  togglePref("sendUsageData")
                      .then((val) => setBooleanSettingText("sendUsageData"));
                },
                child: Text(settingsText["sendUsageData"] ?? ""),
              ),
              Spacer(flex: 20),
            ]),
            Spacer(flex: 1),
            Row(children: [
              Spacer(flex: 1),
              Text("Clear 1 file data"),
              Spacer(flex: 1),
              RaisedButton(
                onPressed: () {
                  var store = SaveDataStore();
                  store.clearSaveFile(1);
                },
                child: Text(settingsText["clear"] ?? ""),
              ),
              Spacer(flex: 20),
            ]),
            Row(children: [
              Spacer(flex: 1),
              Text("Clear 2 file data"),
              Spacer(flex: 1),
              RaisedButton(
                onPressed: () {
                  var store = SaveDataStore();
                  store.clearSaveFile(2);
                },
                child: Text(settingsText["clear"] ?? ""),
              ),
              Spacer(flex: 20),
            ]),
            Row(children: [
              Spacer(flex: 1),
              Text("Clear 3 file data"),
              Spacer(flex: 1),
              RaisedButton(
                onPressed: () {
                  var store = SaveDataStore();
                  store.clearSaveFile(3);
                },
                child: Text(settingsText["clear"] ?? ""),
              ),
              Spacer(flex: 20),
            ]),
            Spacer(flex: 15),
          ]),
        ),
      ),
    );
  }
}
