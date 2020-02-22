import 'package:flutter/material.dart';

import 'common.dart';
import 'overlay.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: Center(
          child: Column(children: <Widget>[
            Text(
              "FOO GAME",
              style: TextStyle(fontSize: 48, color: Colors.white),
            ),
            RaisedButton(
              child: Text(
                "Start",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => showBottomSheet(
                elevation: 2,
                context: context,
                builder: (context) => Container(
                  height: 96,
                  color: darkBlue,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(children: <Widget>[
                      Spacer(flex: 1),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_downward),
                        color: Colors.white,
                      ),
                      Text(
                        "Select file",
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(flex: 256),
                      RaisedButton(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "File 1",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () => Navigator.of(context)
                            .push(PageRouteBuilder(pageBuilder: (context, anim1, anim2) => GamePage(), transitionsBuilder: pageTransition)),
                      ),
                      Spacer(flex: 1),
                      RaisedButton(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "File 2",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {},
                      ),
                      Spacer(flex: 1),
                      RaisedButton(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "File 3",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {},
                      ),
                      Spacer(flex: 32),
                    ]),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
