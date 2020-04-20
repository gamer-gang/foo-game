import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Map<String, String> settingsText = {
    "animations": "",
    "sendUsageData": "",
  };

  @override
  void initState() {
    super.initState();
    setBooleanSettingText(["animations", "sendUsageData"]);
  }

  Future<bool> togglePref(pref, [bool defaultValue]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool next;
    try {
      next = !prefs.getBool(pref);
      // ignore: unused_catch_clause
    } on AssertionError catch (err) {
      next = defaultValue;
    }

    await prefs.setBool(pref, next);

    return next;
  }

  void setBooleanSettingText(dynamic val) async {
    if (val is List) {
      for (dynamic i in val) {
        String next = ((await getPref(i, bool) ?? false) ? "On" : "Off");
        setState(() {
          settingsText.update(i, (value) => next);
        });
      }
    } else {
      String next = ((await getPref(val, bool) ?? false) ? "On" : "Off");
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
                  togglePref("animations").then((val) => setBooleanSettingText("animations"));
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
                  togglePref("sendUsageData").then((val) => setBooleanSettingText("sendUsageData"));
                },
                child: Text(settingsText["sendUsageData"] ?? ""),
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
