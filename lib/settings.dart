import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

Map<String, String> settingsText = {
  "animations": "",
  "sendUsageData": "",
};

class _SettingsPageState extends State<SettingsPage> {
  void setPref(pref, callback) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool next;
    try {
      next = !prefs.getBool(pref);
      // ignore: unused_catch_clause
    } on AssertionError catch (err) {
      next = true;
    }

    prefs.setBool(pref, next);

    callback(next);
  }

  @override
  void initState() {
    super.initState();
    setSetting(["animations", "sendUsageData"]);
  }

  void setSetting(dynamic val) async {
    if (val is List) {
      for (dynamic i in val) {
        String next = ((await getPref(bool, pref: i) ?? false) ? "On" : "Off");
        setState(() {
          settingsText.update(i, (value) => next);
        });
      }
    } else {
      String next = ((await getPref(bool, pref: val) ?? false) ? "On" : "Off");
      setState(() {
        settingsText.update(val, (value) => next);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Settings"),
      ),
      body: Container(
        child: Center(
          child: Column(children: <Widget>[
            Spacer(flex: 1),
            Row(children: <Widget>[
              Spacer(flex: 1),
              Text("Animations"),
              Spacer(flex: 1),
              RaisedButton(
                onPressed: () {
                  setPref("animations", (val) => setSetting("animations"));
                },
                child: Text(settingsText["animations"] ?? "..."),
              ),
              Spacer(flex: 20),
            ]),
            Spacer(flex: 1),
            Row(children: <Widget>[
              Spacer(flex: 1),
              Text("Send anonymous usage data"),
              Spacer(flex: 1),
              RaisedButton(
                onPressed: () {
                  setPref(
                      "sendUsageData", (val) => setSetting("sendUsageData"));
                },
                child: Text(settingsText["sendUsageData"] ?? ""),
              ),
              Spacer(flex: 20)
            ]),
            Spacer(flex: 15)
          ]),
        ),
      ),
    );
  }
}

